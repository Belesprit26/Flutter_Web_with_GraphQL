import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:meta/meta.dart';

import 'clock.dart';
import 'key_value_store.dart';
import 'model/create_order_input.dart';
import 'model/order_record.dart';
import 'model/order_status.dart';
import 'model/payment_method_record.dart';
import 'model/service_record.dart';
import 'order_state_machine.dart';
import 'seed_data.dart';
import 'server_exception.dart';
import 'server_log.dart';
import 'simulated_payment_gateway.dart';
import 'slot_schedule.dart';

class CreateOrderResult {
  const CreateOrderResult({required this.order, required this.replayed});

  final OrderRecord order;

  /// True when the idempotency key had been seen and the original order came
  /// back instead of a new one.
  final bool replayed;
}

/// The in-app server. Owns the orders, the business rules, the simulated
/// payment gateway and the change feed subscriptions listen to. It stands in
/// for a real backend and knows nothing about the client.
class LocalServer {
  LocalServer._({
    required KeyValueStore store,
    required Clock clock,
    required Duration holdDelay,
    required ServerLog log,
    required String Function() newOrderId,
  }) : _store = store,
       _clock = clock,
       _log = log,
       _newOrderId = newOrderId,
       _schedule = SlotSchedule(clock: clock) {
    _gateway = SimulatedPaymentGateway(
      clock: clock,
      holdDelay: holdDelay,
      decliningPaymentMethodIds: <String>{
        for (final PaymentMethodRecord card in seedPaymentMethods)
          if (card.alwaysDeclines) card.id,
      },
      onAnswer: _onGatewayAnswer,
    );
  }

  /// Loads the stored orders and picks up every hold that was still pending
  /// when the page went away. A browser refresh kills in-memory timers, so
  /// without this a pending order would stay pending forever.
  static Future<LocalServer> start({
    required KeyValueStore store,
    Clock clock = const SystemClock(),
    Duration holdDelay = const Duration(milliseconds: 2500),
    ServerLog log = ignoreServerEvents,
    String Function()? newOrderId,
  }) async {
    final LocalServer server = LocalServer._(
      store: store,
      clock: clock,
      holdDelay: holdDelay,
      log: log,
      newOrderId: newOrderId ?? _randomOrderId,
    );
    await server._load();
    return server;
  }

  static const String currency = 'ZAR';
  static const String _orderKeyPrefix = 'lb.v1.order.';

  final KeyValueStore _store;
  final Clock _clock;
  final ServerLog _log;
  final String Function() _newOrderId;
  final SlotSchedule _schedule;
  late final SimulatedPaymentGateway _gateway;

  final Map<String, OrderRecord> _orders = <String, OrderRecord>{};

  /// "userId|idempotencyKey" -> order id. Rebuilt from the orders on start.
  final Map<String, String> _orderIdByKey = <String, String>{};

  final StreamController<OrderRecord> _changes =
      StreamController<OrderRecord>.broadcast();

  // Catalogue

  List<ServiceRecord> get services => seedServices;

  /// Every demo user has the same saved cards.
  List<PaymentMethodRecord> paymentMethodsFor(String userId) =>
      seedPaymentMethods;

  List<(SlotWindow, bool)> slots(int days) => <(SlotWindow, bool)>[
    for (final SlotWindow window in _schedule.upcoming(days))
      (window, _isBookable(window)),
  ];

  // Orders

  /// Null when the order doesn't exist or isn't the caller's - the two look
  /// the same from outside. Falls back to storage when the order isn't in
  /// memory, so an order created in another tab can still be opened.
  Future<OrderRecord?> findOrder({
    required String userId,
    required String orderId,
  }) async {
    final OrderRecord? order =
        _orders[orderId] ?? await _loadFromStorage(orderId);
    if (order == null || order.userId != userId) {
      return null;
    }
    return order;
  }

  Future<CreateOrderResult> createOrder({
    required String userId,
    required CreateOrderInput input,
  }) async {
    final CreateOrderResult result = _replayOrInsert(userId, input);
    if (result.replayed) {
      return result;
    }
    await _persist(result.order);
    _gateway.requestHold(
      orderId: result.order.id,
      paymentMethodId: result.order.card.paymentMethodId,
      requestedAt: result.order.holdRequestedAt,
    );
    return result;
  }

  /// The order now, then every change to it, ending once it's terminal.
  Stream<OrderRecord> watchOrder({
    required String userId,
    required String orderId,
  }) {
    final StreamController<OrderRecord> controller =
        StreamController<OrderRecord>();
    StreamSubscription<OrderRecord>? changes;
    OrderRecord? latest;

    Future<void> finish() async {
      await changes?.cancel();
      await controller.close();
    }

    void emit(OrderRecord order) {
      latest = order;
      controller.add(order);
      if (OrderStateMachine.isTerminal(order.status)) {
        unawaited(finish());
      }
    }

    controller.onListen = () async {
      // Listen for changes before reading the current state, so a hold that
      // settles in between can't be missed.
      final List<OrderRecord> early = <OrderRecord>[];
      changes = _changes.stream
          .where((OrderRecord order) => order.id == orderId)
          .listen((OrderRecord order) {
            if (latest == null) {
              early.add(order);
            } else {
              emit(order);
            }
          });

      final OrderRecord? current = await findOrder(
        userId: userId,
        orderId: orderId,
      );
      if (current == null) {
        controller.addError(
          const ServerException(ErrorCodes.notFound, 'Order not found.'),
        );
        await finish();
        return;
      }
      emit(early.isEmpty ? current : early.last);
    };
    controller.onCancel = () => changes?.cancel();
    return controller.stream;
  }

  /// Applies the gateway's answer. Guarded: if the order isn't HOLD_PENDING
  /// any more - already settled, or a late or repeated answer - it's a no-op
  /// that returns false, so a terminal order can never flip.
  @visibleForTesting
  Future<bool> settleHold(String orderId, HoldOutcome outcome) async {
    final OrderRecord? order = _orders[orderId];
    if (order == null || order.status != OrderStatus.holdPending) {
      return false;
    }
    final OrderStatus next = outcome == HoldOutcome.placed
        ? OrderStatus.holdPlaced
        : OrderStatus.holdFailed;
    if (!OrderStateMachine.canTransition(order.status, next)) {
      throw IllegalTransition(orderId: orderId, from: order.status, to: next);
    }

    final OrderRecord settled = order.settled(
      status: next,
      at: _clock.now(),
      message: next == OrderStatus.holdPlaced
          ? 'Your bank placed the hold. Nothing has been charged yet.'
          : 'Your bank declined the hold. Nothing was charged - try another card.',
    );
    _orders[orderId] = settled;
    await _persist(settled);
    if (!_changes.isClosed) {
      _changes.add(settled);
    }
    _log(
      next == OrderStatus.holdPlaced
          ? 'server.hold.placed'
          : 'server.hold.failed',
      <String, Object?>{'orderId': orderId},
    );
    return true;
  }

  Future<void> dispose() async {
    _gateway.dispose();
    await _changes.close();
  }

  // Steps 1 to 3 of createOrder run as one synchronous block, with no await
  // between looking the key up and inserting the order. Dart runs a
  // synchronous block to completion before anything else gets a turn, so two
  // requests with the same key can't both miss the lookup. A database does
  // the same job with a unique index on (user_id, idempotency_key) and
  // INSERT ... ON CONFLICT.
  CreateOrderResult _replayOrInsert(String userId, CreateOrderInput input) {
    // 1. Replay first. The original was valid when it was made, so it isn't
    //    validated again (its slot may have gone since).
    final String? existingId =
        _orderIdByKey[_keyFor(userId, input.idempotencyKey)];
    if (existingId != null) {
      final OrderRecord original = _orders[existingId]!;
      final Map<String, Object?> fields = <String, Object?>{
        'orderId': original.id,
        'idempotencyKey': input.idempotencyKey,
      };
      if (original.fingerprint != input.fingerprint) {
        _log('server.order.key_reused_rejected', fields);
        throw const ServerException(
          ErrorCodes.idempotencyKeyReused,
          'This idempotency key was already used for a different order.',
        );
      }
      _log('server.order.replayed', fields);
      return CreateOrderResult(order: original, replayed: true);
    }

    // 2. Validate against the current state.
    final List<ServiceRecord> services = _validServices(input.serviceIds);
    final SlotWindow slot = _validSlot(input.slotId);
    final PaymentMethodRecord card = _validCard(userId, input.paymentMethodId);

    // 3. Insert.
    final OrderRecord order = _newOrder(userId, input, services, slot, card);
    _remember(order);
    _log('server.order.created', <String, Object?>{
      'orderId': order.id,
      'idempotencyKey': input.idempotencyKey,
      'fingerprint': input.fingerprint,
    });
    return CreateOrderResult(order: order, replayed: false);
  }

  List<ServiceRecord> _validServices(List<String> ids) {
    if (ids.isEmpty || ids.length > 2 || ids.toSet().length != ids.length) {
      throw const ServerException(
        ErrorCodes.validationFailed,
        'Choose one or two different services.',
      );
    }
    return <ServiceRecord>[
      for (final String id in ids)
        services.firstWhere(
          (ServiceRecord service) => service.id == id,
          orElse: () => throw ServerException(
            ErrorCodes.validationFailed,
            'Unknown service "$id".',
          ),
        ),
    ];
  }

  SlotWindow _validSlot(String id) {
    final SlotWindow? slot = _schedule.parse(id);
    if (slot == null) {
      throw ServerException(ErrorCodes.validationFailed, 'Unknown slot "$id".');
    }
    if (!_isBookable(slot)) {
      throw const ServerException(
        ErrorCodes.slotUnavailable,
        'That time is no longer available. Pick another slot.',
      );
    }
    return slot;
  }

  PaymentMethodRecord _validCard(String userId, String id) {
    for (final PaymentMethodRecord card in paymentMethodsFor(userId)) {
      if (card.id == id) {
        return card;
      }
    }
    throw const ServerException(
      ErrorCodes.paymentMethodInvalid,
      "That card isn't one of your saved cards.",
    );
  }

  /// In the future, inside the booking horizon, not closed, and not held by
  /// another order that's still live. A failed hold frees its slot.
  bool _isBookable(SlotWindow slot) {
    final DateTime now = _clock.now();
    return slot.startsAt.isAfter(now) &&
        slot.startsAt.isBefore(
          now.add(const Duration(days: SlotSchedule.maxDays + 1)),
        ) &&
        !SlotSchedule.closedBySeed(slot.id) &&
        !_orders.values.any(
          (OrderRecord order) =>
              order.slot.slotId == slot.id &&
              order.status != OrderStatus.holdFailed,
        );
  }

  OrderRecord _newOrder(
    String userId,
    CreateOrderInput input,
    List<ServiceRecord> services,
    SlotWindow slot,
    PaymentMethodRecord card,
  ) {
    String id = _newOrderId();
    while (_orders.containsKey(id)) {
      id = _newOrderId();
    }
    final DateTime now = _clock.now();
    return OrderRecord(
      id: id,
      userId: userId,
      idempotencyKey: input.idempotencyKey,
      fingerprint: input.fingerprint,
      status: OrderStatus.holdPending,
      items: <OrderItemRecord>[
        for (final ServiceRecord service in services)
          OrderItemRecord(
            serviceId: service.id,
            name: service.name,
            priceCents: service.priceCents,
          ),
      ],
      slot: BookedSlotRecord(
        slotId: slot.id,
        startsAt: slot.startsAt,
        endsAt: slot.endsAt,
      ),
      card: CardSnapshotRecord(
        paymentMethodId: card.id,
        brand: card.brand,
        last4: card.last4,
      ),
      // The server's total, from its own prices. The client's is an estimate.
      totalCents: services.fold(
        0,
        (int total, ServiceRecord service) => total + service.priceCents,
      ),
      currency: currency,
      timeline: <OrderEventRecord>[
        OrderEventRecord(
          id: OrderRecord.eventId(id, 1),
          type: OrderEventType.created,
          at: now,
          message: 'Order created.',
        ),
        OrderEventRecord(
          id: OrderRecord.eventId(id, 2),
          type: OrderEventType.holdRequested,
          at: now,
          message: 'Hold requested from your card.',
        ),
      ],
      createdAt: now,
      updatedAt: now,
      holdRequestedAt: now,
    );
  }

  void _onGatewayAnswer(String orderId, HoldOutcome outcome) {
    unawaited(
      settleHold(orderId, outcome).then<void>(
        (_) {},
        onError: (Object error, StackTrace stackTrace) {
          _log('server.hold.settle_failed', <String, Object?>{
            'orderId': orderId,
            'error': '$error',
          });
        },
      ),
    );
  }

  Future<void> _load() async {
    final Map<String, String> stored = await _store.readAll(
      prefix: _orderKeyPrefix,
    );
    for (final MapEntry<String, String> entry in stored.entries) {
      final OrderRecord? order = _parse(entry.key, entry.value);
      if (order != null) {
        _remember(order);
      }
    }
    for (final OrderRecord order in _orders.values) {
      _resumeIfPending(order);
    }
  }

  Future<OrderRecord?> _loadFromStorage(String orderId) async {
    final String key = '$_orderKeyPrefix$orderId';
    final String? raw = await _store.read(key);
    if (raw == null) {
      return null;
    }
    final OrderRecord? order = _parse(key, raw);
    if (order == null) {
      return null;
    }
    // Memory may have caught up while storage was being read.
    final OrderRecord? known = _orders[orderId];
    if (known != null) {
      return known;
    }
    _remember(order);
    _resumeIfPending(order);
    return order;
  }

  /// A record that can't be read is skipped and logged, never a crash - one
  /// bad record shouldn't take every other order down with it.
  OrderRecord? _parse(String key, String raw) {
    try {
      return OrderRecord.fromJson(jsonDecode(raw));
    } on FormatException catch (error) {
      _log('server.record.skipped', <String, Object?>{
        'key': key,
        'reason': error.message,
      });
      return null;
    }
  }

  void _resumeIfPending(OrderRecord order) {
    if (order.status != OrderStatus.holdPending) {
      return;
    }
    _gateway.requestHold(
      orderId: order.id,
      paymentMethodId: order.card.paymentMethodId,
      requestedAt: order.holdRequestedAt,
    );
    _log('server.hold.resumed_on_boot', <String, Object?>{'orderId': order.id});
  }

  void _remember(OrderRecord order) {
    _orders[order.id] = order;
    _orderIdByKey[_keyFor(order.userId, order.idempotencyKey)] = order.id;
  }

  Future<void> _persist(OrderRecord order) =>
      _store.write('$_orderKeyPrefix${order.id}', jsonEncode(order.toJson()));

  static String _keyFor(String userId, String idempotencyKey) =>
      '$userId|$idempotencyKey';

  static final Random _random = Random.secure();

  static String _randomOrderId() {
    const String alphabet = 'abcdefghjkmnpqrstuvwxyz23456789';
    return 'ord-${String.fromCharCodes(<int>[for (int i = 0; i < 8; i++) alphabet.codeUnitAt(_random.nextInt(alphabet.length))])}';
  }
}

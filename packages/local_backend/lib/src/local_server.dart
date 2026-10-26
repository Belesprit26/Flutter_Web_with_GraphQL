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
import 'simulated_payment_gateway.dart';
import 'slot_schedule.dart';

class CreateOrderResult {
  const CreateOrderResult({required this.order, required this.replayed});

  final OrderRecord order;

  /// True when the idempotency key had been seen and the original order came
  /// back instead of a new one.
  final bool replayed;
}

/// The in-app server: the orders, the business rules, the simulated payment
/// gateway and the change feed subscriptions listen to. It stands in for a
/// real backend and knows nothing about the client.
class LocalServer {
  LocalServer._({
    required KeyValueStore store,
    required Clock clock,
    required Duration holdDelay,
    required String Function() newOrderId,
  }) : _store = store,
       _clock = clock,
       _newOrderId = newOrderId,
       _schedule = SlotSchedule(clock: clock) {
    _gateway = SimulatedPaymentGateway(
      clock: clock,
      holdDelay: holdDelay,
      decliningPaymentMethodIds: <String>{
        for (final PaymentMethodRecord card in seedPaymentMethods)
          if (card.alwaysDeclines) card.id,
      },
      onAnswer: (String orderId, HoldOutcome outcome) =>
          unawaited(settleHold(orderId, outcome)),
    );
  }

  /// Loads the stored orders and picks up every hold that was still pending
  /// when the page went away. A refresh kills in-memory timers, so without
  /// this a pending order would stay pending forever.
  static Future<LocalServer> start({
    required KeyValueStore store,
    Clock clock = const SystemClock(),
    Duration holdDelay = const Duration(milliseconds: 2500),
    String Function()? newOrderId,
  }) async {
    final LocalServer server = LocalServer._(
      store: store,
      clock: clock,
      holdDelay: holdDelay,
      newOrderId: newOrderId ?? _randomOrderId,
    );
    await server._load();
    return server;
  }

  static const String _orderKeyPrefix = 'lb.v1.order.';

  final KeyValueStore _store;
  final Clock _clock;
  final String Function() _newOrderId;
  final SlotSchedule _schedule;
  late final SimulatedPaymentGateway _gateway;

  final Map<String, OrderRecord> _orders = <String, OrderRecord>{};

  /// "userId|idempotencyKey" -> order id. Rebuilt from the orders on start.
  final Map<String, String> _orderIdByKey = <String, String>{};

  final StreamController<OrderRecord> _changes =
      StreamController<OrderRecord>.broadcast();

  List<ServiceRecord> get services => seedServices;

  List<PaymentMethodRecord> get paymentMethods => seedPaymentMethods;

  List<SlotWindow> slots(int days) => _schedule.upcoming(days);

  /// Falls back to storage when the order isn't in memory, so an order made
  /// in another tab can still be opened.
  Future<OrderRecord?> findOrder(String orderId) async =>
      _orders[orderId] ?? await _loadFromStorage(orderId);

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

  /// The order now, then every change, ending once it's terminal. It listens
  /// for changes before reading the current state, so a hold that settles in
  /// between can't be missed.
  Stream<OrderRecord> watchOrder(String orderId) {
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
      final OrderRecord? current = await findOrder(orderId);
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
  /// that returns false, so a finished order can never flip.
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
    return true;
  }

  Future<void> dispose() async {
    _gateway.dispose();
    await _changes.close();
  }

  // The replay lookup, the validation and the insert run as one synchronous
  // block, with no await in between. Dart runs a synchronous block to the end
  // before anything else gets a turn, so two requests with the same key can't
  // both miss the lookup. A database does this with a unique index on
  // (user_id, idempotency_key) and INSERT ... ON CONFLICT.
  CreateOrderResult _replayOrInsert(String userId, CreateOrderInput input) {
    // Replay first. The original was valid when it was made, so it isn't
    // validated again.
    final String? existingId =
        _orderIdByKey[_keyFor(userId, input.idempotencyKey)];
    if (existingId != null) {
      return CreateOrderResult(order: _orders[existingId]!, replayed: true);
    }

    final OrderRecord order = _newOrder(
      userId,
      input,
      _validServices(input.serviceIds),
      _validSlot(input.slotId),
      _validCard(input.paymentMethodId),
    );
    _remember(order);
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

  SlotWindow _validSlot(String id) =>
      _schedule.find(id) ??
      (throw const ServerException(
        ErrorCodes.slotUnavailable,
        "That time isn't available any more. Pick another.",
      ));

  PaymentMethodRecord _validCard(String id) => paymentMethods.firstWhere(
    (PaymentMethodRecord card) => card.id == id,
    orElse: () => throw const ServerException(
      ErrorCodes.paymentMethodInvalid,
      "That card isn't one of your saved cards.",
    ),
  );

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
      // The server's total, from its own prices.
      totalCents: services.fold(
        0,
        (int total, ServiceRecord service) => total + service.priceCents,
      ),
      currency: 'ZAR',
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

  Future<void> _load() async {
    final Map<String, String> stored = await _store.readAll(
      prefix: _orderKeyPrefix,
    );
    for (final String raw in stored.values) {
      final OrderRecord? order = _parse(raw);
      if (order != null) {
        _remember(order);
      }
    }
    _orders.values.forEach(_resumeIfPending);
  }

  Future<OrderRecord?> _loadFromStorage(String orderId) async {
    final String? raw = await _store.read('$_orderKeyPrefix$orderId');
    final OrderRecord? order = raw == null ? null : _parse(raw);
    if (order == null || _orders.containsKey(orderId)) {
      return _orders[orderId] ?? order;
    }
    _remember(order);
    _resumeIfPending(order);
    return order;
  }

  /// A record that can't be read is skipped, never a crash.
  OrderRecord? _parse(String raw) {
    try {
      return OrderRecord.fromJson(jsonDecode(raw));
    } on FormatException {
      return null;
    }
  }

  void _resumeIfPending(OrderRecord order) {
    if (order.status == OrderStatus.holdPending) {
      _gateway.requestHold(
        orderId: order.id,
        paymentMethodId: order.card.paymentMethodId,
        requestedAt: order.holdRequestedAt,
      );
    }
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

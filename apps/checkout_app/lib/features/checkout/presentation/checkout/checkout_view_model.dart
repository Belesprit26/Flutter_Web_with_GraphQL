import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:checkout_app/core/app_failure.dart';
import 'package:checkout_app/core/app_logger.dart';
import 'package:checkout_app/core/result.dart';
import '../../domain/entities/catalog.dart';
import '../../domain/entities/checkout.dart';
import '../../domain/entities/money.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/usecases/place_order_use_case.dart';
import '../command.dart';

enum CheckoutPhase {
  loading,
  loadFailed,

  /// A confirm from before a reload never got its answer; sending it again.
  resuming,

  /// Back on a checkout that already became an order.
  alreadyPlaced,
  ready,
}

/// The selection from the checkout URL.
typedef CheckoutArgs = ({List<String> serviceIds, String? slotId});

class CheckoutViewModel extends ChangeNotifier {
  CheckoutViewModel({
    required CheckoutArgs args,
    required String userId,
    required CatalogRepository catalog,
    required PlaceOrderUseCase placeOrder,
    required CheckoutAttemptStore attempts,
    required AppLogger logger,
  }) : _requestedServiceIds = args.serviceIds.toSet().toList(),
       _urlSlotId = args.slotId,
       _selectedSlotId = args.slotId,
       _userId = userId,
       _catalog = catalog,
       _placeOrder = placeOrder,
       _attempts = attempts {
    confirm = Command0<Order>(
      _confirm,
      onDuplicate: () => logger.log(
        'checkout.duplicate_suppressed',
        fields: const <String, Object?>{'layer': 'command'},
      ),
    )..addListener(notifyListeners);
    unawaited(_start());
  }

  final List<String> _requestedServiceIds;
  final String? _urlSlotId;
  final String _userId;
  final CatalogRepository _catalog;
  final PlaceOrderUseCase _placeOrder;
  final CheckoutAttemptStore _attempts;

  /// Layers 1 and 2 of the duplicate protection: a confirm while one is
  /// running is dropped, and the button is bound to [Command.running].
  late final Command0<Order> confirm;

  CheckoutPhase _phase = CheckoutPhase.loading;
  AppFailure? _loadFailure;
  String? _alreadyPlacedOrderId;
  String? _notice;
  List<Service> _services = const <Service>[];
  List<Slot> _slots = const <Slot>[];
  List<PaymentMethod> _cards = const <PaymentMethod>[];
  String? _selectedSlotId;
  String? _selectedCardId;
  String? _orderToOpen;

  CheckoutPhase get phase => _phase;
  AppFailure? get loadFailure => _loadFailure;
  String? get alreadyPlacedOrderId => _alreadyPlacedOrderId;

  /// Something worth telling the user above the form, e.g. that the slot in
  /// the link has gone.
  String? get notice => _notice;
  List<Service> get services => _services;
  List<Slot> get slots => _slots;
  List<PaymentMethod> get cards => _cards;
  String? get selectedSlotId => _selectedSlotId;
  String? get selectedCardId => _selectedCardId;
  List<String> get serviceIds => <String>[
    for (final Service service in _services) service.id,
  ];

  bool get hasValidServices => _services.isNotEmpty && _services.length <= 2;

  /// From catalogue prices. The order page shows the server's total.
  Money get estimatedTotal => _services.fold(
    const Money.zar(0),
    (Money total, Service service) => total + service.price,
  );

  bool get canConfirm =>
      _phase == CheckoutPhase.ready &&
      hasValidServices &&
      _selectedSlotId != null &&
      _selectedCardId != null &&
      !confirm.running;

  /// The order to open next, handed over once.
  String? takeOrderToOpen() {
    final String? orderId = _orderToOpen;
    _orderToOpen = null;
    return orderId;
  }

  void selectSlot(String slotId) {
    final bool available = _slots.any(
      (Slot slot) => slot.id == slotId && slot.available,
    );
    if (!available) {
      return;
    }
    _selectedSlotId = slotId;
    _notice = null;
    confirm.clearResult();
  }

  void selectCard(String paymentMethodId) {
    _selectedCardId = paymentMethodId;
    confirm.clearResult();
  }

  Future<void> retry() => _start();

  Future<void> _start() async {
    _phase = CheckoutPhase.loading;
    _loadFailure = null;
    notifyListeners();

    final CheckoutAttempt? attempt = await _attempts.load(_userId);
    if (attempt != null && attempt.state == CheckoutAttemptState.submitting) {
      // The user already confirmed and the answer never came back. Sending
      // it again with the same key can't make a second order.
      _phase = CheckoutPhase.resuming;
      notifyListeners();
      final Result<Order>? resumed = await _placeOrder.resume(userId: _userId);
      switch (resumed) {
        case Ok<Order>(:final Order value):
          _orderToOpen = value.id;
          notifyListeners();
          return;
        case Err<Order>(:final AppFailure failure):
          _notice = failure.userMessage;
        case null:
          break;
      }
    } else if (attempt != null &&
        attempt.state == CheckoutAttemptState.completed &&
        attempt.orderId != null &&
        _isThisCheckout(attempt.request)) {
      // Layer 5: back on a checkout that already became an order. Show that,
      // never a form that could be submitted again.
      _alreadyPlacedOrderId = attempt.orderId;
      _phase = CheckoutPhase.alreadyPlaced;
      notifyListeners();
      return;
    }

    await _loadOptions();
  }

  /// The exact checkout from before: same services and the same slot in the
  /// URL. Arriving from the catalogue has no slot yet, so booking the same
  /// services again starts a fresh checkout.
  bool _isThisCheckout(CheckoutRequest request) =>
      _urlSlotId != null &&
      request.slotId == _urlSlotId &&
      setEquals(request.serviceIds.toSet(), _requestedServiceIds.toSet());

  Future<void> _loadOptions() async {
    final (
      Result<List<Service>> services,
      Result<List<Slot>> slots,
      Result<List<PaymentMethod>> cards,
    ) = await (
      _catalog.services(),
      _catalog.availableSlots(),
      _catalog.paymentMethods(),
    ).wait;

    switch ((services, slots, cards)) {
      case (
        Ok<List<Service>>(value: final List<Service> allServices),
        Ok<List<Slot>>(value: final List<Slot> allSlots),
        Ok<List<PaymentMethod>>(value: final List<PaymentMethod> allCards),
      ):
        _services = <Service>[
          for (final String id in _requestedServiceIds)
            ...allServices.where((Service service) => service.id == id),
        ];
        _slots = allSlots;
        _cards = allCards;
        _keepSlotOnlyIfStillAvailable();
        _selectedCardId ??= allCards.isEmpty ? null : allCards.first.id;
        _phase = CheckoutPhase.ready;
      case (Err<List<Service>>(:final AppFailure failure), _, _) ||
          (_, Err<List<Slot>>(:final AppFailure failure), _) ||
          (_, _, Err<List<PaymentMethod>>(:final AppFailure failure)):
        _loadFailure = failure;
        _phase = CheckoutPhase.loadFailed;
    }
    notifyListeners();
  }

  void _keepSlotOnlyIfStillAvailable() {
    final String? selected = _selectedSlotId;
    if (selected == null) {
      return;
    }
    final bool available = _slots.any(
      (Slot slot) => slot.id == selected && slot.available,
    );
    if (!available) {
      _selectedSlotId = null;
      _notice = 'That time is no longer available. Pick another.';
    }
  }

  Future<Result<Order>> _confirm() async {
    final String? slotId = _selectedSlotId;
    final String? cardId = _selectedCardId;
    if (!hasValidServices || slotId == null || cardId == null) {
      return const Err<Order>(
        ValidationFailure(
          developerMessage: 'Confirm pressed without a complete selection.',
          userMessage: 'Choose a time and a card first.',
        ),
      );
    }

    final Result<Order> result = await _placeOrder(
      userId: _userId,
      request: CheckoutRequest(
        serviceIds: serviceIds,
        slotId: slotId,
        paymentMethodId: cardId,
      ),
    );
    switch (result) {
      case Ok<Order>(:final Order value):
        _orderToOpen = value.id;
      case Err<Order>(failure: SlotUnavailableFailure()):
        await _refreshSlots();
      case Err<Order>():
        break;
    }
    return result;
  }

  /// Someone else took the slot: show the current availability.
  Future<void> _refreshSlots() async {
    if (await _catalog.availableSlots() case Ok<List<Slot>>(
      :final List<Slot> value,
    )) {
      _slots = value;
      _keepSlotOnlyIfStillAvailable();
    }
  }

  @override
  void dispose() {
    confirm
      ..removeListener(notifyListeners)
      ..dispose();
    super.dispose();
  }
}

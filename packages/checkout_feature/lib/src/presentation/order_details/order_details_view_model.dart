import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/app_failure.dart';
import '../../core/result.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/usecases/place_order_use_case.dart';

/// Sealed, so the screen's switch has to handle every case.
sealed class OrderDetailsState {
  const OrderDetailsState();
}

final class OrderLoading extends OrderDetailsState {
  const OrderLoading();
}

final class OrderLoaded extends OrderDetailsState {
  const OrderLoaded(this.order);

  final Order order;
}

/// The server answered: no such order for this account.
final class OrderMissing extends OrderDetailsState {
  const OrderMissing();
}

final class OrderLoadFailed extends OrderDetailsState {
  const OrderLoadFailed(this.failure);

  final AppFailure failure;
}

class OrderDetailsViewModel extends ChangeNotifier {
  OrderDetailsViewModel({
    required String orderId,
    required String userId,
    required OrderRepository orders,
    required PlaceOrderUseCase placeOrder,
    Duration stillConfirmingAfter = const Duration(seconds: 10),
  }) : _orderId = orderId,
       _userId = userId,
       _orders = orders,
       _placeOrder = placeOrder,
       _stillConfirmingAfter = stillConfirmingAfter {
    _watch();
  }

  final String _orderId;
  final String _userId;
  final OrderRepository _orders;
  final PlaceOrderUseCase _placeOrder;
  final Duration _stillConfirmingAfter;

  StreamSubscription<Result<Order?>>? _subscription;
  Timer? _watchdog;

  OrderDetailsState _state = const OrderLoading();
  bool _stillConfirming = false;

  OrderDetailsState get state => _state;

  /// The hold is taking longer than usual. Informs, never fails: the server
  /// may still settle it, and it's safe to leave the page.
  bool get stillConfirming => _stillConfirming;

  void retry() {
    unawaited(_subscription?.cancel());
    _state = const OrderLoading();
    notifyListeners();
    _watch();
  }

  /// "Try again" after a declined hold. The next confirm is a new payment
  /// attempt with a new key. Returns the services to check out again.
  Future<List<String>> startOver() async {
    await _placeOrder.abandon(userId: _userId);
    return switch (_state) {
      OrderLoaded(:final Order order) => <String>[
        for (final OrderItem item in order.items) item.serviceId,
      ],
      _ => const <String>[],
    };
  }

  void _watch() {
    _subscription = _orders.watchOrder(_orderId).listen(_onResult);
  }

  void _onResult(Result<Order?> result) {
    switch (result) {
      case Ok<Order?>(value: null):
        _state = const OrderMissing();
      case Ok<Order?>(:final Order value):
        _state = OrderLoaded(value);
        _updateWatchdog(value);
      case Err<Order?>(:final AppFailure failure):
        // A failed update shouldn't replace an order that's already showing.
        if (_state is! OrderLoaded) {
          _state = OrderLoadFailed(failure);
        }
    }
    notifyListeners();
  }

  void _updateWatchdog(Order order) {
    if (order.status.isTerminal) {
      _watchdog?.cancel();
      _stillConfirming = false;
      return;
    }
    _watchdog ??= Timer(_stillConfirmingAfter, () {
      _stillConfirming = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _watchdog?.cancel();
    unawaited(_subscription?.cancel());
    super.dispose();
  }
}

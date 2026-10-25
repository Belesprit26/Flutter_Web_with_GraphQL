import 'model/order_status.dart';

/// Which status changes are allowed. HOLD_PLACED and HOLD_FAILED are terminal
/// in this slice. Capturing or releasing a hold would add moves out of
/// HOLD_PLACED; the table has room for them, they just aren't built.
abstract final class OrderStateMachine {
  static const Map<OrderStatus, Set<OrderStatus>> _allowed =
      <OrderStatus, Set<OrderStatus>>{
        OrderStatus.holdPending: <OrderStatus>{
          OrderStatus.holdPlaced,
          OrderStatus.holdFailed,
        },
        OrderStatus.holdPlaced: <OrderStatus>{},
        OrderStatus.holdFailed: <OrderStatus>{},
      };

  static bool canTransition(OrderStatus from, OrderStatus to) =>
      _allowed[from]!.contains(to);

  static bool isTerminal(OrderStatus status) => _allowed[status]!.isEmpty;
}

/// A status change the table doesn't allow. That's a bug, not an expected
/// outcome, so it's thrown rather than returned.
class IllegalTransition implements Exception {
  const IllegalTransition({
    required this.orderId,
    required this.from,
    required this.to,
  });

  final String orderId;
  final OrderStatus from;
  final OrderStatus to;

  @override
  String toString() =>
      'IllegalTransition: ${from.wireName} -> ${to.wireName} for order $orderId';
}

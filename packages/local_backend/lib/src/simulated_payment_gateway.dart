import 'dart:async';

import 'clock.dart';

enum HoldOutcome { placed, declined }

typedef HoldAnswer = void Function(String orderId, HoldOutcome outcome);

/// Stands in for the card provider. Accepting a hold request is not the same
/// as the hold being placed: the answer arrives later, the way a provider's
/// webhook would, and the order stays HOLD_PENDING until it does.
class SimulatedPaymentGateway {
  SimulatedPaymentGateway({
    required Clock clock,
    required Duration holdDelay,
    required Set<String> decliningPaymentMethodIds,
    required HoldAnswer onAnswer,
  }) : _clock = clock,
       _holdDelay = holdDelay,
       _decliningPaymentMethodIds = decliningPaymentMethodIds,
       _onAnswer = onAnswer;

  final Clock _clock;
  final Duration _holdDelay;
  final Set<String> _decliningPaymentMethodIds;
  final HoldAnswer _onAnswer;
  final Map<String, Timer> _waiting = <String, Timer>{};

  /// Asks for a hold that was requested at [requestedAt]. After a reload the
  /// server calls this again for every pending order with the original time,
  /// so the answer lands when it would have; one that's already overdue
  /// arrives straight away.
  void requestHold({
    required String orderId,
    required String paymentMethodId,
    required DateTime requestedAt,
  }) {
    final Duration remaining = requestedAt
        .add(_holdDelay)
        .difference(_clock.now());
    final HoldOutcome outcome =
        _decliningPaymentMethodIds.contains(paymentMethodId)
        ? HoldOutcome.declined
        : HoldOutcome.placed;

    _waiting.remove(orderId)?.cancel();
    _waiting[orderId] = Timer(
      remaining.isNegative ? Duration.zero : remaining,
      () {
        _waiting.remove(orderId);
        _onAnswer(orderId, outcome);
      },
    );
  }

  void dispose() {
    for (final Timer timer in _waiting.values) {
      timer.cancel();
    }
    _waiting.clear();
  }
}

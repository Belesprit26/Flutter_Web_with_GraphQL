import 'package:uuid/uuid.dart';

import 'package:checkout_app/core/app_failure.dart';
import 'package:checkout_app/core/app_logger.dart';
import 'package:checkout_app/core/result.dart';
import '../entities/checkout.dart';
import '../entities/order.dart';
import '../repositories/repositories.dart';

/// Places at most one order per intended checkout. This is layer 3 of the
/// duplicate protection: single-flight in memory, plus a saved checkout
/// attempt whose idempotency key survives retries and reloads. The server's
/// own idempotency (layer 4) backs it up.
class PlaceOrderUseCase {
  PlaceOrderUseCase({
    required OrderRepository orders,
    required CheckoutAttemptStore attempts,
    required AppLogger logger,
    String Function()? newIdempotencyKey,
    DateTime Function()? now,
  }) : _orders = orders,
       _attempts = attempts,
       _logger = logger,
       _newIdempotencyKey = newIdempotencyKey ?? const Uuid().v4,
       _now = now ?? DateTime.now;

  final OrderRepository _orders;
  final CheckoutAttemptStore _attempts;
  final AppLogger _logger;
  final String Function() _newIdempotencyKey;
  final DateTime Function() _now;

  /// "userId|fingerprint" -> the confirm already running for it.
  final Map<String, Future<Result<Order>>> _inFlight =
      <String, Future<Result<Order>>>{};

  /// Confirms [request] for [userId]. A second call for the same user and
  /// selection while the first is running gets the first one's future back.
  /// Without that, two calls would both find no attempt, both mint a key,
  /// and the server would correctly make two orders.
  Future<Result<Order>> call({
    required String userId,
    required CheckoutRequest request,
  }) {
    final String flightKey = '$userId|${request.fingerprint}';
    final Future<Result<Order>>? running = _inFlight[flightKey];
    if (running != null) {
      _logger.log(
        'checkout.duplicate_suppressed',
        fields: <String, Object?>{
          'layer': 'single_flight',
          'fingerprint': request.fingerprint,
        },
      );
      return running;
    }
    final Future<Result<Order>> confirm = _place(userId, request);
    _inFlight[flightKey] = confirm;
    confirm.whenComplete(() => _inFlight.remove(flightKey)).ignore();
    return confirm;
  }

  /// After a reload: if the last confirm never got its answer, sends it again
  /// with the same key. The server either replays the order it already made
  /// or makes it now - never both. Null when there's nothing to resume.
  Future<Result<Order>?> resume({required String userId}) async {
    final CheckoutAttempt? attempt = await _attempts.load(userId);
    if (attempt == null || attempt.state != CheckoutAttemptState.submitting) {
      return null;
    }
    _logger.log(
      'checkout.attempt.resumed',
      fields: <String, Object?>{'idempotencyKey': attempt.idempotencyKey},
    );
    return call(userId: userId, request: attempt.request);
  }

  /// "Try again" after a declined hold. The next confirm is a new payment
  /// attempt with a new key, even with the same card.
  Future<void> abandon({required String userId}) async {
    final CheckoutAttempt? attempt = await _attempts.load(userId);
    if (attempt != null) {
      await _attempts.save(attempt.withState(CheckoutAttemptState.abandoned));
    }
  }

  Future<Result<Order>> _place(String userId, CheckoutRequest request) async {
    if (!request.hasValidServices) {
      return const Err<Order>(
        ValidationFailure(
          developerMessage: 'Checkout needs one or two different services.',
          userMessage: 'Choose one or two services.',
        ),
      );
    }

    // Reuse the open attempt for this exact selection; anything else -
    // nothing yet, completed, abandoned, or a changed selection - is a new
    // attempt with a new key. A completed attempt is never reused: booking
    // the same thing again is a new order.
    final CheckoutAttempt? last = await _attempts.load(userId);
    final CheckoutAttempt attempt =
        last != null && last.isOpen && last.fingerprint == request.fingerprint
        ? last
        : CheckoutAttempt(
            idempotencyKey: _newIdempotencyKey(),
            userId: userId,
            request: request,
            state: CheckoutAttemptState.draft,
            createdAt: _now(),
          );

    // Saved before the request goes out, so a reload mid-request finds this
    // key and replays it instead of minting a new one.
    final CheckoutAttempt submitting = attempt.withState(
      CheckoutAttemptState.submitting,
    );
    await _attempts.save(submitting);
    final Map<String, Object?> fields = <String, Object?>{
      'idempotencyKey': attempt.idempotencyKey,
      'fingerprint': request.fingerprint,
    };
    _logger.log('checkout.confirm.started', fields: fields);

    final Result<PlacedOrder> result = await _orders.createOrder(
      idempotencyKey: attempt.idempotencyKey,
      request: request,
    );

    switch (result) {
      case Ok<PlacedOrder>(value: final PlacedOrder placed):
        await _attempts.save(
          submitting.withState(
            CheckoutAttemptState.completed,
            orderId: placed.order.id,
          ),
        );
        _logger.log(
          'checkout.confirm.succeeded',
          fields: <String, Object?>{
            ...fields,
            'orderId': placed.order.id,
            'replayed': placed.replayed,
          },
        );
        return Ok<Order>(placed.order);

      case Err<PlacedOrder>(:final AppFailure failure):
        if (!_outcomeUnknown(failure)) {
          // A definite no: nothing was created. Back to draft. Changing the
          // selection changes the fingerprint, and so the key.
          await _attempts.save(
            submitting.withState(CheckoutAttemptState.draft),
          );
        }
        // Otherwise it stays submitting, and the next try reuses the key.
        _logger.log(
          'checkout.confirm.failed',
          fields: <String, Object?>{
            ...fields,
            'failure': '${failure.runtimeType}',
          },
        );
        return Err<Order>(failure);
    }
  }

  /// Whether the server may have made the order even though we got no
  /// answer. Exhaustive on purpose: a new failure type has to choose.
  bool _outcomeUnknown(AppFailure failure) => switch (failure) {
    NetworkFailure() || UnexpectedFailure() => true,
    SlotUnavailableFailure() ||
    ValidationFailure() ||
    SessionExpiredFailure() ||
    NotFoundFailure() => false,
  };
}

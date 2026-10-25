import 'dart:convert';

import '../../core/app_logger.dart';
import '../../domain/entities/checkout.dart';
import '../../domain/repositories/repositories.dart';

/// Keeps each user's latest checkout attempt in device storage, so its
/// idempotency key survives a refresh.
class LocalCheckoutAttemptStore implements CheckoutAttemptStore {
  const LocalCheckoutAttemptStore({
    required LocalStore store,
    required AppLogger logger,
  }) : _store = store,
       _logger = logger;

  final LocalStore _store;
  final AppLogger _logger;

  static String keyFor(String userId) => 'checkout_attempt.v1.$userId';

  @override
  Future<CheckoutAttempt?> load(String userId) async {
    final String? raw = await _store.read(keyFor(userId));
    if (raw == null) {
      return null;
    }
    try {
      return _fromJson(jsonDecode(raw));
    } on FormatException catch (error) {
      // An unreadable attempt is treated as no attempt: the next confirm
      // starts a fresh one.
      _logger.log(
        'checkout.attempt.unreadable',
        fields: <String, Object?>{'userId': userId, 'reason': error.message},
      );
      return null;
    }
  }

  @override
  Future<void> save(CheckoutAttempt attempt) =>
      _store.write(keyFor(attempt.userId), jsonEncode(_toJson(attempt)));

  static Map<String, Object?> _toJson(CheckoutAttempt attempt) =>
      <String, Object?>{
        'idempotencyKey': attempt.idempotencyKey,
        'userId': attempt.userId,
        'serviceIds': attempt.request.serviceIds,
        'slotId': attempt.request.slotId,
        'paymentMethodId': attempt.request.paymentMethodId,
        'state': attempt.state.name,
        'createdAt': attempt.createdAt.toUtc().toIso8601String(),
        'orderId': attempt.orderId,
      };

  static CheckoutAttempt _fromJson(Object? json) {
    if (json case {
      'idempotencyKey': final String idempotencyKey,
      'userId': final String userId,
      'serviceIds': final List<Object?> serviceIds,
      'slotId': final String slotId,
      'paymentMethodId': final String paymentMethodId,
      'state': final String state,
      'createdAt': final String createdAt,
      'orderId': final String? orderId,
    } when serviceIds.every((Object? id) => id is String)) {
      return CheckoutAttempt(
        idempotencyKey: idempotencyKey,
        userId: userId,
        request: CheckoutRequest(
          serviceIds: List<String>.unmodifiable(serviceIds.cast<String>()),
          slotId: slotId,
          paymentMethodId: paymentMethodId,
        ),
        state: CheckoutAttemptState.values.firstWhere(
          (CheckoutAttemptState value) => value.name == state,
          orElse: () =>
              throw FormatException('Unknown attempt state "$state".'),
        ),
        createdAt: DateTime.parse(createdAt),
        orderId: orderId,
      );
    }
    throw const FormatException('Not a stored checkout attempt.');
  }
}

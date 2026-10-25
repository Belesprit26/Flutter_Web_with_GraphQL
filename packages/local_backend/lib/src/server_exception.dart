/// The `extensions.code` values the server puts on GraphQL errors.
abstract final class ErrorCodes {
  static const String unauthenticated = 'UNAUTHENTICATED';
  static const String validationFailed = 'VALIDATION_FAILED';
  static const String slotUnavailable = 'SLOT_UNAVAILABLE';
  static const String paymentMethodInvalid = 'PAYMENT_METHOD_INVALID';
  static const String idempotencyKeyReused = 'IDEMPOTENCY_KEY_REUSED';
  static const String notFound = 'NOT_FOUND';
  static const String notImplemented = 'NOT_IMPLEMENTED';
  static const String internal = 'INTERNAL';
}

/// An expected failure, sent to the client as a GraphQL error with [code].
class ServerException implements Exception {
  const ServerException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'ServerException($code): $message';
}

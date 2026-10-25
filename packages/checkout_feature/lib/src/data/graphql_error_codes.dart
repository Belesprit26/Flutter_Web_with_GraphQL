/// The `extensions.code` values the GraphQL server can return. The client
/// keeps its own copy: it can't import the server, and a real backend
/// wouldn't be a Dart package anyway.
abstract final class GraphQLErrorCodes {
  static const String unauthenticated = 'UNAUTHENTICATED';
  static const String validationFailed = 'VALIDATION_FAILED';
  static const String slotUnavailable = 'SLOT_UNAVAILABLE';
  static const String paymentMethodInvalid = 'PAYMENT_METHOD_INVALID';
  static const String idempotencyKeyReused = 'IDEMPOTENCY_KEY_REUSED';
  static const String notFound = 'NOT_FOUND';
  static const String notImplemented = 'NOT_IMPLEMENTED';
  static const String internal = 'INTERNAL';
}

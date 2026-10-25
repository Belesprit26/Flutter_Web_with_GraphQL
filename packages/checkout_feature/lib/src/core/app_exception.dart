/// What went wrong, thrown by the data layer. Repositories turn these into
/// [AppFailure]s, which say what to tell the user.
sealed class AppException implements Exception {
  const AppException(this.developerMessage);

  /// For logs and tests, never for the user.
  final String developerMessage;

  @override
  String toString() => '$runtimeType: $developerMessage';
}

/// The request may not have reached the server, or its answer didn't come
/// back. The outcome is unknown.
final class NetworkException extends AppException {
  const NetworkException(super.developerMessage);
}

/// The answer arrived but didn't fit the expected types.
final class MappingException extends AppException {
  const MappingException(super.developerMessage);
}

/// The server says nobody is signed in.
final class UnauthenticatedException extends AppException {
  const UnauthenticatedException(super.developerMessage);
}

/// The chosen slot can't be booked any more.
final class SlotTakenException extends AppException {
  const SlotTakenException(super.developerMessage);
}

/// The server rejected the request's input.
final class InvalidRequestException extends AppException {
  const InvalidRequestException(super.developerMessage);
}

/// The chosen card isn't one of the user's saved cards.
final class PaymentMethodRejectedException extends AppException {
  const PaymentMethodRejectedException(super.developerMessage);
}

/// The thing asked for doesn't exist for this user.
final class NotFoundException extends AppException {
  const NotFoundException(super.developerMessage);
}

/// Any other server error. [code] is kept for the logs.
final class ServerRejectedException extends AppException {
  const ServerRejectedException({required this.code, required String message})
    : super(message);

  final String? code;

  @override
  String toString() => 'ServerRejectedException($code): $developerMessage';
}

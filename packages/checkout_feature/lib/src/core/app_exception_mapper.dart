import 'app_exception.dart';
import 'app_failure.dart';

/// The one place an [AppException] (what went wrong) becomes an [AppFailure]
/// (what to tell the user).
AppFailure mapExceptionToFailure(AppException exception) {
  final String detail = exception.toString();
  return switch (exception) {
    NetworkException() => NetworkFailure(developerMessage: detail),
    UnauthenticatedException() => SessionExpiredFailure(
      developerMessage: detail,
    ),
    SlotTakenException() => SlotUnavailableFailure(developerMessage: detail),
    InvalidRequestException() => ValidationFailure(developerMessage: detail),
    PaymentMethodRejectedException() => ValidationFailure(
      developerMessage: detail,
      userMessage: "That card can't be used. Choose another saved card.",
    ),
    NotFoundException() => NotFoundFailure(developerMessage: detail),
    MappingException() ||
    ServerRejectedException() => UnexpectedFailure(developerMessage: detail),
  };
}

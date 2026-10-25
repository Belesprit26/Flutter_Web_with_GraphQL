import 'package:ferry/ferry.dart';

import '../../core/app_exception.dart';
import '../graphql_error_codes.dart';

/// Turns a ferry response with no usable data into the [AppException] that
/// says what went wrong.
AppException exceptionFromResponse(
  OperationResponse<Object?, Object?> response,
) {
  final LinkException? linkException = response.linkException;
  if (linkException != null) {
    // A response that didn't fit the generated types arrives as a link
    // exception wrapping an Error (built_value's DeserializationError).
    // Anything else on the link means we don't know if the server got it.
    final Object? original = linkException.originalException;
    if (original is Error) {
      return MappingException(
        'Response did not fit the generated types: $original',
      );
    }
    return NetworkException('$linkException');
  }

  // GraphQLError's type is inferred: it lives in gql_exec, which this package
  // only reaches through ferry.
  final error = response.graphqlErrors?.firstOrNull;
  if (error == null) {
    return const MappingException('Response had neither data nor errors.');
  }
  final Object? code = error.extensions?['code'];
  return switch (code) {
    GraphQLErrorCodes.unauthenticated => UnauthenticatedException(
      error.message,
    ),
    GraphQLErrorCodes.slotUnavailable => SlotTakenException(error.message),
    GraphQLErrorCodes.validationFailed => InvalidRequestException(
      error.message,
    ),
    GraphQLErrorCodes.paymentMethodInvalid => PaymentMethodRejectedException(
      error.message,
    ),
    GraphQLErrorCodes.notFound => NotFoundException(error.message),
    _ => ServerRejectedException(
      code: code is String ? code : null,
      message: error.message,
    ),
  };
}

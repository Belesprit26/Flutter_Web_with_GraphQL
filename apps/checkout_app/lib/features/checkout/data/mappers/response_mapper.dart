import 'package:checkout_app/core/app_failure.dart';
import 'package:ferry/ferry.dart';

import '../graphql_error_codes.dart';

/// What to tell the user about a ferry response with no usable data.
AppFailure failureFromResponse(OperationResponse<Object?, Object?> response) {
  final LinkException? linkException = response.linkException;
  if (linkException != null) {
    // A response that didn't fit the generated types arrives as a link
    // exception wrapping an Error (built_value's DeserializationError).
    // Anything else on the link means we don't know if the server got it.
    final Object? original = linkException.originalException;
    if (original is Error) {
      return UnexpectedFailure(
        developerMessage: 'Response did not fit the generated types: $original',
      );
    }
    return NetworkFailure(developerMessage: '$linkException');
  }

  // GraphQLError's type is inferred: it lives in gql_exec, which this app
  // only reaches through ferry.
  final error = response.graphqlErrors?.firstOrNull;
  if (error == null) {
    return const UnexpectedFailure(
      developerMessage: 'Response had neither data nor errors.',
    );
  }
  final String detail = '${error.extensions?['code']}: ${error.message}';
  return switch (error.extensions?['code']) {
    GraphQLErrorCodes.unauthenticated => SessionExpiredFailure(
      developerMessage: detail,
    ),
    GraphQLErrorCodes.slotUnavailable => SlotUnavailableFailure(
      developerMessage: detail,
    ),
    GraphQLErrorCodes.validationFailed => ValidationFailure(
      developerMessage: detail,
    ),
    GraphQLErrorCodes.paymentMethodInvalid => ValidationFailure(
      developerMessage: detail,
      userMessage: "That card can't be used. Choose another saved card.",
    ),
    GraphQLErrorCodes.notFound => NotFoundFailure(developerMessage: detail),
    _ => UnexpectedFailure(developerMessage: detail),
  };
}

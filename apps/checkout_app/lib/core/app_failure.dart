import 'package:equatable/equatable.dart';

/// What to tell the user. [userMessage] is safe to render as it is; the
/// developer detail is for logs and never reaches the screen.
sealed class AppFailure extends Equatable {
  const AppFailure({required this.userMessage, required this.developerMessage});

  final String userMessage;
  final String developerMessage;

  // Equatable doesn't compare runtime types, and two failures with the same
  // messages are still different failures.
  @override
  List<Object?> get props => <Object?>[
    runtimeType,
    userMessage,
    developerMessage,
  ];
}

/// The outcome is unknown: the request may or may not have reached the
/// server. Retrying with the same idempotency key is safe.
final class NetworkFailure extends AppFailure {
  const NetworkFailure({
    required super.developerMessage,
    super.userMessage =
        "We couldn't reach the server. Check your connection and try again.",
  });
}

final class SlotUnavailableFailure extends AppFailure {
  const SlotUnavailableFailure({
    required super.developerMessage,
    super.userMessage = 'That time was just taken. Pick another slot.',
  });
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({
    required super.developerMessage,
    super.userMessage = 'Something in your booking needs another look.',
  });
}

final class SessionExpiredFailure extends AppFailure {
  const SessionExpiredFailure({
    required super.developerMessage,
    super.userMessage = 'Your session has ended. Sign in again to continue.',
  });
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure({
    required super.developerMessage,
    super.userMessage =
        "We couldn't find that order for this account in this browser.",
  });
}

/// Something that shouldn't happen. Also treated as an unknown outcome, so a
/// retry keeps its idempotency key.
final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({
    required super.developerMessage,
    super.userMessage = 'Something went wrong on our side. Please try again.',
  });
}

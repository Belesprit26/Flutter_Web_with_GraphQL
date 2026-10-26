import 'app_failure.dart';

/// What a repository or use case hands back: a value or a failure, never a
/// thrown exception. A switch over it has to handle both.
sealed class Result<T> {
  const Result();

  R fold<R>({
    required R Function(T value) ok,
    required R Function(AppFailure failure) err,
  }) => switch (this) {
    Ok<T>(:final T value) => ok(value),
    Err<T>(:final AppFailure failure) => err(failure),
  };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final AppFailure failure;
}

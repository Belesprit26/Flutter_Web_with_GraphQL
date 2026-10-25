/// Where the server gets the time. Injected so tests can move it.
abstract interface class Clock {
  /// The current time in UTC.
  DateTime now();
}

class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now().toUtc();
}

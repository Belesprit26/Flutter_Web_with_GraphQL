import 'dart:developer' as developer;

/// Structured logging: a dotted event name plus fields, e.g.
/// `checkout.confirm.started` with the idempotency key. Tests swap in a
/// recording fake and assert on what was logged.
abstract interface class AppLogger {
  void log(String event, {Map<String, Object?> fields});
}

/// Writes to the developer console. No SDK.
class ConsoleAppLogger implements AppLogger {
  const ConsoleAppLogger();

  @override
  void log(String event, {Map<String, Object?> fields = const {}}) {
    developer.log(
      fields.isEmpty ? event : '$event $fields',
      name: 'brightnook',
    );
  }
}

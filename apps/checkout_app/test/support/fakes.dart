import 'package:checkout_app/features/checkout/checkout.dart';
import 'package:ferry/ferry.dart';

/// Device storage in a map. Keep the same instance across two "page loads"
/// and it behaves like localStorage across a refresh.
class InMemoryLocalStore implements LocalStore {
  final Map<String, String> values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async {
    values[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }
}

typedef LoggedEvent = ({String event, Map<String, Object?> fields});

/// Captures what was logged so a test can assert on it.
class RecordingAppLogger implements AppLogger {
  final List<LoggedEvent> entries = <LoggedEvent>[];

  List<String> get events => <String>[
    for (final LoggedEvent entry in entries) entry.event,
  ];

  @override
  void log(String event, {Map<String, Object?> fields = const {}}) =>
      entries.add((event: event, fields: fields));
}

class ConnectionDropped implements Exception {
  const ConnectionDropped();
}

/// Passes everything through, except that the first CreateOrder's answer is
/// lost on the way back - the server makes the order, the client never hears
/// about it. That's a dropped connection, or a refresh mid-confirm.
Link loseFirstCreateOrderAnswer(Link inner) {
  bool lost = false;
  return Link.function((request, [forward]) async* {
    if (!lost && request.operation.operationName == 'CreateOrder') {
      lost = true;
      await inner.request(request).drain<void>();
      throw const ConnectionDropped();
    }
    yield* inner.request(request);
  });
}

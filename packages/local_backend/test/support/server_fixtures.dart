import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/create_order_input.dart';
import 'package:local_backend/src/server_exception.dart';
import 'package:local_backend/src/slot_schedule.dart';
import 'package:test/test.dart';

/// 10:00 SAST on Saturday 24 October 2026.
final DateTime saturdayMorning = DateTime.utc(2026, 10, 24, 8);

class FakeClock implements Clock {
  FakeClock([DateTime? start]) : current = start ?? saturdayMorning;

  DateTime current;

  @override
  DateTime now() => current;

  void advance(Duration duration) => current = current.add(duration);
}

/// Captures what the server logged so a test can assert on it.
class RecordingServerLog {
  final List<String> events = <String>[];

  void call(String event, Map<String, Object?> fields) => events.add(event);
}

Future<LocalServer> startServer({
  KeyValueStore? store,
  Clock? clock,
  Duration holdDelay = const Duration(milliseconds: 10),
  ServerLog log = ignoreServerEvents,
}) {
  int next = 0;
  return LocalServer.start(
    store: store ?? InMemoryKeyValueStore(),
    clock: clock ?? FakeClock(),
    holdDelay: holdDelay,
    log: log,
    newOrderId: () => 'ord-test${++next}',
  );
}

/// The first [count] slot ids that can be booked right now.
List<String> openSlots(LocalServer server, {int count = 1}) => <String>[
  for (final (SlotWindow window, bool available) in server.slots(7))
    if (available) window.id,
].take(count).toList();

CreateOrderInput orderInput({
  required String slotId,
  String key = 'key-1',
  List<String> serviceIds = const <String>['svc-regular-clean'],
  String paymentMethodId = 'pm-visa-4242',
}) => CreateOrderInput(
  idempotencyKey: key,
  serviceIds: serviceIds,
  slotId: slotId,
  paymentMethodId: paymentMethodId,
);

Matcher throwsServerError(String code) => throwsA(
  isA<ServerException>().having(
    (ServerException error) => error.code,
    'code',
    code,
  ),
);

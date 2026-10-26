import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/create_order_input.dart';
import 'package:local_backend/src/server_exception.dart';
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

Future<LocalServer> startServer({
  KeyValueStore? store,
  Clock? clock,
  Duration holdDelay = const Duration(milliseconds: 10),
}) {
  int next = 0;
  return LocalServer.start(
    store: store ?? InMemoryKeyValueStore(),
    clock: clock ?? FakeClock(),
    holdDelay: holdDelay,
    newOrderId: () => 'ord-test${++next}',
  );
}

String firstSlot(LocalServer server) => server.slots(7).first.id;

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

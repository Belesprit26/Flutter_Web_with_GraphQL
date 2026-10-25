import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/order_record.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  late LocalServer server;
  late OrderRecord order;

  setUp(() async {
    server = await startServer(holdDelay: const Duration(hours: 1));
    order = (await server.createOrder(
      userId: 'demo',
      input: orderInput(slotId: openSlots(server).first),
    )).order;
  });

  tearDown(() => server.dispose());

  test('the owner can read their order', () async {
    expect(
      await server.findOrder(userId: 'demo', orderId: order.id),
      isNotNull,
    );
  });

  test("someone else's order reads as missing", () async {
    expect(
      await server.findOrder(userId: 'someone-else', orderId: order.id),
      isNull,
    );
  });

  test('an unknown id reads as missing', () async {
    expect(await server.findOrder(userId: 'demo', orderId: 'ord-nope'), isNull);
  });

  test("watching someone else's order fails with NOT_FOUND", () async {
    await expectLater(
      server.watchOrder(userId: 'someone-else', orderId: order.id),
      emitsError(
        isA<Exception>().having(
          (Exception error) => '$error',
          'message',
          contains(ErrorCodes.notFound),
        ),
      ),
    );
  });
}

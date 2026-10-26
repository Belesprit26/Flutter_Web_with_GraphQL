import 'package:local_backend/local_backend.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  late InMemoryKeyValueStore store;
  late LocalServer server;
  late String slot;

  setUp(() async {
    store = InMemoryKeyValueStore();
    server = await startServer(
      store: store,
      holdDelay: const Duration(hours: 1),
    );
    slot = firstSlot(server);
  });

  tearDown(() => server.dispose());

  Future<int> storedOrders() async =>
      (await store.readAll(prefix: 'lb.v1.order.')).length;

  test('the same key returns the original order as a replay', () async {
    final CreateOrderResult first = await server.createOrder(
      userId: 'demo',
      input: orderInput(slotId: slot),
    );
    final CreateOrderResult second = await server.createOrder(
      userId: 'demo',
      input: orderInput(slotId: slot),
    );

    expect(first.replayed, isFalse);
    expect(second.replayed, isTrue);
    expect(second.order.id, first.order.id);
    expect(await storedOrders(), 1);
  });

  test(
    'two requests with the same key at the same moment make one order',
    () async {
      final List<CreateOrderResult> results =
          await Future.wait(<Future<CreateOrderResult>>[
            server.createOrder(
              userId: 'demo',
              input: orderInput(slotId: slot),
            ),
            server.createOrder(
              userId: 'demo',
              input: orderInput(slotId: slot),
            ),
          ]);

      expect(results[0].order.id, results[1].order.id);
      expect(await storedOrders(), 1);
    },
  );

  group('validation', () {
    test('needs one or two different, known services', () async {
      for (final List<String> serviceIds in <List<String>>[
        <String>[],
        <String>['svc-regular-clean', 'svc-deep-clean', 'svc-laundry'],
        <String>['svc-laundry', 'svc-laundry'],
        <String>['svc-does-not-exist'],
      ]) {
        await expectLater(
          server.createOrder(
            userId: 'demo',
            input: orderInput(slotId: slot, serviceIds: serviceIds),
          ),
          throwsServerError(ErrorCodes.validationFailed),
          reason: '$serviceIds',
        );
      }
    });

    test('a slot that is not in the next 7 days is unavailable', () async {
      await expectLater(
        server.createOrder(
          userId: 'demo',
          input: orderInput(slotId: 'slot-20261020-0800'),
        ),
        throwsServerError(ErrorCodes.slotUnavailable),
      );
    });

    test('a card that is not a saved card is rejected', () async {
      await expectLater(
        server.createOrder(
          userId: 'demo',
          input: orderInput(slotId: slot, paymentMethodId: 'pm-stolen-1111'),
        ),
        throwsServerError(ErrorCodes.paymentMethodInvalid),
      );
    });
  });
}

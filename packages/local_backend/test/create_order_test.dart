import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/order_record.dart';
import 'package:local_backend/src/model/order_status.dart';
import 'package:local_backend/src/slot_schedule.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  late FakeClock clock;
  late InMemoryKeyValueStore store;
  late RecordingServerLog log;
  late LocalServer server;
  late String slot;

  setUp(() async {
    clock = FakeClock();
    store = InMemoryKeyValueStore();
    log = RecordingServerLog();
    server = await startServer(
      store: store,
      clock: clock,
      log: log.call,
      holdDelay: const Duration(hours: 1),
    );
    slot = openSlots(server).first;
  });

  tearDown(() => server.dispose());

  Future<int> storedOrderCount() async =>
      (await store.readAll(prefix: 'lb.v1.order.')).length;

  group('creating an order', () {
    test(
      'starts pending with a snapshot, a server total and a timeline',
      () async {
        final CreateOrderResult result = await server.createOrder(
          userId: 'demo',
          input: orderInput(
            slotId: slot,
            serviceIds: <String>['svc-regular-clean', 'svc-deep-clean'],
          ),
        );
        final OrderRecord order = result.order;

        expect(result.replayed, isFalse);
        expect(order.status, OrderStatus.holdPending);
        expect(order.totalCents, 45000 + 125000);
        expect(order.currency, 'ZAR');
        expect(order.slot.slotId, slot);
        expect(order.card.last4, '4242');
        expect(
          order.timeline.map((OrderEventRecord event) => event.id),
          <String>['${order.id}-e1', '${order.id}-e2'],
        );
        expect(await storedOrderCount(), 1);
        expect(log.events, contains('server.order.created'));
      },
    );
  });

  group('idempotency', () {
    test('the same key and request returns the original as a replay', () async {
      final CreateOrderResult first = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: slot),
      );
      final CreateOrderResult second = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: slot),
      );

      expect(second.replayed, isTrue);
      expect(second.order.id, first.order.id);
      expect(await storedOrderCount(), 1);
      expect(log.events, contains('server.order.replayed'));
    });

    test('service order does not change the fingerprint', () async {
      await server.createOrder(
        userId: 'demo',
        input: orderInput(
          slotId: slot,
          serviceIds: <String>['svc-laundry', 'svc-windows'],
        ),
      );
      final CreateOrderResult again = await server.createOrder(
        userId: 'demo',
        input: orderInput(
          slotId: slot,
          serviceIds: <String>['svc-windows', 'svc-laundry'],
        ),
      );

      expect(again.replayed, isTrue);
    });

    test('the same key with a different request is rejected', () async {
      await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: slot),
      );

      await expectLater(
        server.createOrder(
          userId: 'demo',
          input: orderInput(
            slotId: slot,
            paymentMethodId: 'pm-mastercard-5454',
          ),
        ),
        throwsServerError(ErrorCodes.idempotencyKeyReused),
      );
      expect(await storedOrderCount(), 1);
      expect(log.events, contains('server.order.key_reused_rejected'));
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
        expect(
          results.where((CreateOrderResult result) => result.replayed),
          hasLength(1),
        );
        expect(await storedOrderCount(), 1);
      },
    );

    test('a replay is not validated again', () async {
      final CreateOrderResult first = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: slot),
      );
      clock.advance(const Duration(days: 30)); // the slot is now in the past

      final CreateOrderResult replay = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: slot),
      );

      expect(replay.replayed, isTrue);
      expect(replay.order.id, first.order.id);
    });

    test('keys are per user', () async {
      final CreateOrderResult mine = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: slot),
      );
      final CreateOrderResult theirs = await server.createOrder(
        userId: 'someone-else',
        input: orderInput(slotId: openSlots(server).first),
      );

      expect(theirs.replayed, isFalse);
      expect(theirs.order.id, isNot(mine.order.id));
    });
  });

  group('validation', () {
    Future<CreateOrderResult> create({
      List<String> serviceIds = const <String>['svc-regular-clean'],
      String? slotId,
      String paymentMethodId = 'pm-visa-4242',
      String key = 'key-1',
    }) => server.createOrder(
      userId: 'demo',
      input: orderInput(
        key: key,
        slotId: slotId ?? slot,
        serviceIds: serviceIds,
        paymentMethodId: paymentMethodId,
      ),
    );

    test('needs one or two different, known services', () async {
      for (final List<String> serviceIds in <List<String>>[
        <String>[],
        <String>['svc-regular-clean', 'svc-deep-clean', 'svc-laundry'],
        <String>['svc-laundry', 'svc-laundry'],
        <String>['svc-does-not-exist'],
      ]) {
        await expectLater(
          create(serviceIds: serviceIds),
          throwsServerError(ErrorCodes.validationFailed),
          reason: '$serviceIds',
        );
      }
    });

    test('an unknown slot id is a validation failure', () async {
      await expectLater(
        create(slotId: 'slot-20261025-0900'),
        throwsServerError(ErrorCodes.validationFailed),
      );
    });

    test('a slot in the past is unavailable', () async {
      await expectLater(
        create(slotId: 'slot-20261020-0800'),
        throwsServerError(ErrorCodes.slotUnavailable),
      );
    });

    test('a seeded closed slot is unavailable', () async {
      final String closed = server
          .slots(7)
          .firstWhere(((SlotWindow, bool) slot) => !slot.$2)
          .$1
          .id;
      await expectLater(
        create(slotId: closed),
        throwsServerError(ErrorCodes.slotUnavailable),
      );
    });

    test('a booked slot is unavailable, and a failed hold frees it', () async {
      final CreateOrderResult first = await create(
        key: 'key-1',
        paymentMethodId: 'pm-visa-0002',
      );

      await expectLater(
        create(key: 'key-2'),
        throwsServerError(ErrorCodes.slotUnavailable),
      );

      await server.settleHold(first.order.id, HoldOutcome.declined);
      final CreateOrderResult retry = await create(key: 'key-3');
      expect(retry.order.slot.slotId, slot);
    });

    test('a card that is not one of the saved cards is rejected', () async {
      await expectLater(
        create(paymentMethodId: 'pm-stolen-1111'),
        throwsServerError(ErrorCodes.paymentMethodInvalid),
      );
    });
  });

  group('holds', () {
    late LocalServer quick;

    setUp(() async => quick = await startServer());
    tearDown(() => quick.dispose());

    test('a good card ends placed after the delay', () async {
      final CreateOrderResult result = await quick.createOrder(
        userId: 'demo',
        input: orderInput(slotId: openSlots(quick).first),
      );

      final OrderRecord settled = await quick
          .watchOrder(userId: 'demo', orderId: result.order.id)
          .last;
      expect(settled.status, OrderStatus.holdPlaced);
    });

    test('the declining card ends failed with a readable message', () async {
      final CreateOrderResult result = await quick.createOrder(
        userId: 'demo',
        input: orderInput(
          slotId: openSlots(quick).first,
          paymentMethodId: 'pm-visa-0002',
        ),
      );

      final OrderRecord settled = await quick
          .watchOrder(userId: 'demo', orderId: result.order.id)
          .last;
      expect(settled.status, OrderStatus.holdFailed);
      expect(settled.timeline.last.type, OrderEventType.holdFailed);
      expect(settled.timeline.last.message, contains('declined'));
    });
  });
}

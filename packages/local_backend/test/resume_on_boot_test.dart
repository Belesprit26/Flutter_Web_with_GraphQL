import 'dart:convert';

import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/order_record.dart';
import 'package:local_backend/src/model/order_status.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

// A browser refresh is a new server over the same storage: the in-memory
// timers are gone, the records are not.
void main() {
  late FakeClock clock;
  late InMemoryKeyValueStore store;

  setUp(() {
    clock = FakeClock();
    store = InMemoryKeyValueStore();
  });

  /// Creates a pending order, then "closes the tab" before it settles.
  Future<OrderRecord> pendingOrderLeftBehind({String key = 'key-1'}) async {
    final LocalServer before = await startServer(
      store: store,
      clock: clock,
      holdDelay: const Duration(milliseconds: 2500),
    );
    final CreateOrderResult result = await before.createOrder(
      userId: 'demo',
      input: orderInput(key: key, slotId: openSlots(before).first),
    );
    await before.dispose();
    return result.order;
  }

  test(
    'a hold that came due while the page was gone settles on start',
    () async {
      final OrderRecord pending = await pendingOrderLeftBehind();
      clock.advance(const Duration(seconds: 10));
      final RecordingServerLog log = RecordingServerLog();

      final LocalServer after = await startServer(
        store: store,
        clock: clock,
        holdDelay: const Duration(milliseconds: 2500),
        log: log.call,
      );
      addTearDown(after.dispose);

      final OrderRecord settled = await after
          .watchOrder(userId: 'demo', orderId: pending.id)
          .last;
      expect(settled.status, OrderStatus.holdPlaced);
      expect(log.events, contains('server.hold.resumed_on_boot'));
    },
  );

  test('a hold that is not due yet waits for the rest of its delay', () async {
    final OrderRecord pending = await pendingOrderLeftBehind();
    clock.advance(const Duration(milliseconds: 2450));

    final LocalServer after = await startServer(
      store: store,
      clock: clock,
      holdDelay: const Duration(milliseconds: 2500),
    );
    addTearDown(after.dispose);

    final List<OrderStatus> statuses = await after
        .watchOrder(userId: 'demo', orderId: pending.id)
        .map((OrderRecord order) => order.status)
        .toList();
    expect(statuses, <OrderStatus>[
      OrderStatus.holdPending,
      OrderStatus.holdPlaced,
    ]);
  });

  test('after a reload the same key replays the stored order', () async {
    final OrderRecord pending = await pendingOrderLeftBehind();

    final LocalServer after = await startServer(
      store: store,
      clock: clock,
      holdDelay: const Duration(hours: 1),
    );
    addTearDown(after.dispose);

    final CreateOrderResult replay = await after.createOrder(
      userId: 'demo',
      input: orderInput(slotId: pending.slot.slotId),
    );
    expect(replay.replayed, isTrue);
    expect(replay.order.id, pending.id);
  });

  test('a record that cannot be read is skipped and logged', () async {
    final OrderRecord good = await pendingOrderLeftBehind();
    await store.write('lb.v1.order.broken', '{"id": "broken"');
    await store.write(
      'lb.v1.order.wrong-shape',
      jsonEncode(<String, Object?>{'id': 'wrong-shape'}),
    );
    final RecordingServerLog log = RecordingServerLog();

    final LocalServer after = await startServer(
      store: store,
      clock: clock,
      holdDelay: const Duration(hours: 1),
      log: log.call,
    );
    addTearDown(after.dispose);

    expect(await after.findOrder(userId: 'demo', orderId: good.id), isNotNull);
    expect(
      log.events.where((String event) => event == 'server.record.skipped'),
      hasLength(2),
    );
  });

  test(
    'an order written by another tab after start is read from storage',
    () async {
      final LocalServer thisTab = await startServer(
        store: store,
        clock: clock,
        holdDelay: const Duration(hours: 1),
      );
      addTearDown(thisTab.dispose);
      final OrderRecord fromOtherTab = await pendingOrderLeftBehind();

      final OrderRecord? found = await thisTab.findOrder(
        userId: 'demo',
        orderId: fromOtherTab.id,
      );
      expect(found?.id, fromOtherTab.id);
    },
  );
}

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
  Future<OrderRecord> pendingOrderLeftBehind() async {
    final LocalServer before = await startServer(
      store: store,
      clock: clock,
      holdDelay: const Duration(milliseconds: 2500),
    );
    final CreateOrderResult result = await before.createOrder(
      userId: 'demo',
      input: orderInput(slotId: firstSlot(before)),
    );
    await before.dispose();
    return result.order;
  }

  Future<LocalServer> reload() async {
    final LocalServer after = await startServer(
      store: store,
      clock: clock,
      holdDelay: const Duration(milliseconds: 2500),
    );
    addTearDown(after.dispose);
    return after;
  }

  test(
    'a hold that came due while the page was gone settles on start',
    () async {
      final OrderRecord pending = await pendingOrderLeftBehind();
      clock.advance(const Duration(seconds: 10));

      final LocalServer after = await reload();

      final OrderRecord settled = await after.watchOrder(pending.id).last;
      expect(settled.status, OrderStatus.holdPlaced);
    },
  );

  test('a hold that is not due yet waits for the rest of its delay', () async {
    final OrderRecord pending = await pendingOrderLeftBehind();
    clock.advance(const Duration(milliseconds: 2450));

    final LocalServer after = await reload();

    expect(
      await after
          .watchOrder(pending.id)
          .map((OrderRecord order) => order.status)
          .toList(),
      <OrderStatus>[OrderStatus.holdPending, OrderStatus.holdPlaced],
    );
  });
}

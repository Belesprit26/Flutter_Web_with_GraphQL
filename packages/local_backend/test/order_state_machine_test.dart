import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/order_record.dart';
import 'package:local_backend/src/model/order_status.dart';
import 'package:local_backend/src/order_state_machine.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  test('only pending can move, and only to placed or failed', () {
    for (final OrderStatus from in OrderStatus.values) {
      for (final OrderStatus to in OrderStatus.values) {
        final bool expected =
            from == OrderStatus.holdPending && to != OrderStatus.holdPending;
        expect(
          OrderStateMachine.canTransition(from, to),
          expected,
          reason: '${from.wireName} -> ${to.wireName}',
        );
      }
    }
    expect(OrderStateMachine.isTerminal(OrderStatus.holdPending), isFalse);
    expect(OrderStateMachine.isTerminal(OrderStatus.holdPlaced), isTrue);
    expect(OrderStateMachine.isTerminal(OrderStatus.holdFailed), isTrue);
  });

  group('settling a hold', () {
    late LocalServer server;
    late String orderId;

    setUp(() async {
      // A long hold delay so nothing settles unless the test says so.
      server = await startServer(holdDelay: const Duration(hours: 1));
      orderId = (await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: firstSlot(server)),
      )).order.id;
    });

    tearDown(() => server.dispose());

    test('pending to placed appends the event in the same step', () async {
      expect(await server.settleHold(orderId, HoldOutcome.placed), isTrue);

      final OrderRecord order = (await server.findOrder(orderId))!;
      expect(order.status, OrderStatus.holdPlaced);
      expect(order.timeline.last.type, OrderEventType.holdPlaced);
    });

    test('a late or repeated answer on a finished order is a no-op', () async {
      await server.settleHold(orderId, HoldOutcome.placed);

      expect(await server.settleHold(orderId, HoldOutcome.declined), isFalse);
      final OrderRecord order = (await server.findOrder(orderId))!;
      expect(order.status, OrderStatus.holdPlaced);
      expect(order.timeline, hasLength(3));
    });
  });
}

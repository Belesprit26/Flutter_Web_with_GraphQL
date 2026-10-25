import 'package:local_backend/local_backend.dart';
import 'package:local_backend/src/model/order_record.dart';
import 'package:local_backend/src/model/order_status.dart';
import 'package:local_backend/src/order_state_machine.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  group('transition table', () {
    const Map<OrderStatus, Set<OrderStatus>> allowed =
        <OrderStatus, Set<OrderStatus>>{
          OrderStatus.holdPending: <OrderStatus>{
            OrderStatus.holdPlaced,
            OrderStatus.holdFailed,
          },
          OrderStatus.holdPlaced: <OrderStatus>{},
          OrderStatus.holdFailed: <OrderStatus>{},
        };

    for (final OrderStatus from in OrderStatus.values) {
      for (final OrderStatus to in OrderStatus.values) {
        final bool expected = allowed[from]!.contains(to);
        test('${from.wireName} -> ${to.wireName} is '
            '${expected ? 'allowed' : 'not allowed'}', () {
          expect(OrderStateMachine.canTransition(from, to), expected);
        });
      }
    }

    test('placed and failed are terminal, pending is not', () {
      expect(OrderStateMachine.isTerminal(OrderStatus.holdPending), isFalse);
      expect(OrderStateMachine.isTerminal(OrderStatus.holdPlaced), isTrue);
      expect(OrderStateMachine.isTerminal(OrderStatus.holdFailed), isTrue);
    });
  });

  group('settling a hold', () {
    late LocalServer server;
    late String orderId;

    setUp(() async {
      // A long hold delay so nothing settles unless the test says so.
      server = await startServer(holdDelay: const Duration(hours: 1));
      final CreateOrderResult result = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: openSlots(server).single),
      );
      orderId = result.order.id;
    });

    tearDown(() => server.dispose());

    test(
      'moves pending to placed and appends the event in the same step',
      () async {
        expect(await server.settleHold(orderId, HoldOutcome.placed), isTrue);

        final OrderRecord order = (await server.findOrder(
          userId: 'demo',
          orderId: orderId,
        ))!;
        expect(order.status, OrderStatus.holdPlaced);
        expect(
          order.timeline.map((OrderEventRecord event) => event.type),
          <OrderEventType>[
            OrderEventType.created,
            OrderEventType.holdRequested,
            OrderEventType.holdPlaced,
          ],
        );
      },
    );

    test('a second or late answer on a terminal order is a no-op', () async {
      await server.settleHold(orderId, HoldOutcome.placed);

      expect(await server.settleHold(orderId, HoldOutcome.declined), isFalse);
      expect(await server.settleHold(orderId, HoldOutcome.placed), isFalse);

      final OrderRecord order = (await server.findOrder(
        userId: 'demo',
        orderId: orderId,
      ))!;
      expect(order.status, OrderStatus.holdPlaced);
      expect(order.timeline, hasLength(3));
    });
  });
}

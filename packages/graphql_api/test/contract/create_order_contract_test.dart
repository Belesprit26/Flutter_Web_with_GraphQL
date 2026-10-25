import 'package:graphql_api/graphql_api.dart';
import 'package:test/test.dart';

import 'contract_harness.dart';

void main() {
  late ContractHarness harness;

  setUp(() async => harness = await ContractHarness.start());
  tearDown(() => harness.dispose());

  test('CreateOrder comes back as typed GCreateOrderData', () async {
    final GCreateOrderData_createOrder created = await harness.createOrder();

    expect(created.replayed, isFalse);
    expect(created.order.status, GOrderStatus.HOLD_PENDING);
    expect(created.order.totalCents, 45000);
    expect(created.order.currency, 'ZAR');
    expect(created.order.timeline.map((event) => event.type), <GOrderEventType>[
      GOrderEventType.CREATED,
      GOrderEventType.HOLD_REQUESTED,
    ]);
  });

  test('the same key comes back typed as a replay of the same order', () async {
    final GCreateOrderData_createOrder first = await harness.createOrder();
    final GCreateOrderData_createOrder second = await harness.createOrder(
      slotId: first.order.slot.slotId,
    );

    expect(second.replayed, isTrue);
    expect(second.order.id, first.order.id);
  });
}

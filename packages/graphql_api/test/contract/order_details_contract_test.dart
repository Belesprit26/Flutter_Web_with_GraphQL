import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:test/test.dart';

import 'contract_harness.dart';

void main() {
  late ContractHarness harness;

  setUp(
    () async => harness = await ContractHarness.start(
      holdDelay: const Duration(hours: 1),
    ),
  );
  tearDown(() => harness.dispose());

  test('OrderDetails comes back as typed GOrderDetailsData', () async {
    final GCreateOrderData_createOrder created = await harness.createOrder();

    final OperationResponse<GOrderDetailsData, GOrderDetailsVars> response =
        await harness.run(
          GOrderDetailsReq((b) => b..vars.id = created.order.id),
        );

    expect(response.hasErrors, isFalse, reason: describeErrors(response));
    final GOrderDetailsData_order order = response.data!.order!;
    expect(order.id, created.order.id);
    expect(order.slot.slotId, created.order.slot.slotId);
    expect(order.card.last4, '4242');
    expect(order.items.single.name, 'Regular clean');
  });

  test('an unknown order comes back as null, not an error', () async {
    final OperationResponse<GOrderDetailsData, GOrderDetailsVars> response =
        await harness.run(GOrderDetailsReq((b) => b..vars.id = 'ord-nope'));

    expect(response.hasErrors, isFalse, reason: describeErrors(response));
    expect(response.data!.order, isNull);
  });
}

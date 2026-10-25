import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:test/test.dart';

import 'contract_harness.dart';

void main() {
  late ContractHarness harness;

  setUp(() async => harness = await ContractHarness.start());
  tearDown(() => harness.dispose());

  test('OrderUpdated comes back as typed GOrderUpdatedData, pending then '
      'placed', () async {
    final GCreateOrderData_createOrder created = await harness.createOrder();

    final List<GOrderStatus> statuses = await harness.client
        .request(GOrderUpdatedReq((b) => b..vars.id = created.order.id))
        .where(
          (OperationResponse<GOrderUpdatedData, GOrderUpdatedVars> response) =>
              response.dataSource == DataSource.Link || response.hasErrors,
        )
        .map((response) {
          expect(response.hasErrors, isFalse, reason: describeErrors(response));
          return response.data!.orderUpdated.status;
        })
        .take(2)
        .toList();

    expect(statuses, <GOrderStatus>[
      GOrderStatus.HOLD_PENDING,
      GOrderStatus.HOLD_PLACED,
    ]);
  });

  test(
    'a subscription result updates the watched OrderDetails query',
    () async {
      final GCreateOrderData_createOrder created = await harness.createOrder();
      final GOrderDetailsReq details = GOrderDetailsReq(
        (b) => b..vars.id = created.order.id,
      );

      final Future<GOrderStatus?> placedSeenByQuery = harness.client
          .request(details)
          .map((response) => response.data?.order?.status)
          .firstWhere(
            (GOrderStatus? status) => status == GOrderStatus.HOLD_PLACED,
          );
      final subscription = harness.client
          .request(GOrderUpdatedReq((b) => b..vars.id = created.order.id))
          .listen((_) {});
      addTearDown(subscription.cancel);

      expect(
        await placedSeenByQuery.timeout(const Duration(seconds: 5)),
        GOrderStatus.HOLD_PLACED,
      );
    },
  );
}

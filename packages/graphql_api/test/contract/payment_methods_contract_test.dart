import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:test/test.dart';

import 'contract_harness.dart';

void main() {
  late ContractHarness harness;

  setUp(() async => harness = await ContractHarness.start());
  tearDown(() => harness.dispose());

  test('PaymentMethods comes back as typed GPaymentMethodsData', () async {
    final OperationResponse<GPaymentMethodsData, GPaymentMethodsVars> response =
        await harness.run(GPaymentMethodsReq());

    expect(response.hasErrors, isFalse, reason: describeErrors(response));
    final List<GPaymentMethodsData_paymentMethods> cards = response
        .data!
        .paymentMethods
        .toList();
    expect(cards, hasLength(3));
    expect(cards.map((card) => card.brand), contains(GCardBrand.MASTERCARD));
    expect(cards.every((card) => card.last4.length == 4), isTrue);
  });
}

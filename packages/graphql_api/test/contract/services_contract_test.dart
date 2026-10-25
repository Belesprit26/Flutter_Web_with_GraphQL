import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:test/test.dart';

import 'contract_harness.dart';

// Runs the real operation through the real in-app server and proves the
// server's maps deserialise into the generated types.
void main() {
  late ContractHarness harness;

  setUp(() async => harness = await ContractHarness.start());
  tearDown(() => harness.dispose());

  test('Services comes back as typed GServicesData', () async {
    final OperationResponse<GServicesData, GServicesVars> response =
        await harness.run(GServicesReq());

    expect(response.hasErrors, isFalse, reason: describeErrors(response));
    final List<GServicesData_services> services = response.data!.services
        .toList();
    expect(services, isNotEmpty);
    expect(services.first.id, isNotEmpty);
    expect(services.first.priceCents, greaterThan(0));
  });
}

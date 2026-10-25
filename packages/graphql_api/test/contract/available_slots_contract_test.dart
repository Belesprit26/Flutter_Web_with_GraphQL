import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:test/test.dart';

import 'contract_harness.dart';

void main() {
  late ContractHarness harness;

  setUp(() async => harness = await ContractHarness.start());
  tearDown(() => harness.dispose());

  test('AvailableSlots comes back as typed GAvailableSlotsData', () async {
    final OperationResponse<GAvailableSlotsData, GAvailableSlotsVars> response =
        await harness.run(GAvailableSlotsReq((b) => b..vars.days = 7));

    expect(response.hasErrors, isFalse, reason: describeErrors(response));
    final List<GAvailableSlotsData_availableSlots> slots = response
        .data!
        .availableSlots
        .toList();
    expect(slots, hasLength(28));
    expect(DateTime.parse(slots.first.startsAt).isUtc, isTrue);
    expect(slots.where((slot) => slot.available), isNotEmpty);
  });
}

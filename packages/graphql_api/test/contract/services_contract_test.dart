import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';
import 'package:test/test.dart';

// Runs the real operation through the real in-app server and proves the
// server's maps deserialise into the generated types.
void main() {
  late Client client;

  setUp(() => client = createGraphQLClient(link: LocalServerLink()));
  tearDown(() => client.dispose());

  test('Services comes back as typed GServicesData', () async {
    final OperationResponse<GServicesData, GServicesVars> response =
        await client
            .request(GServicesReq())
            // Stop at the server's answer, or at the first error: a response
            // that doesn't fit the generated types surfaces as an error, not
            // as data from the link.
            .firstWhere(
              (OperationResponse<GServicesData, GServicesVars> response) =>
                  response.dataSource == DataSource.Link || response.hasErrors,
            );

    expect(
      response.hasErrors,
      isFalse,
      reason: '${response.graphqlErrors} ${response.linkException}',
    );
    final List<GServicesData_services> services = response.data!.services
        .toList();
    expect(services, isNotEmpty);
    expect(services.first.id, isNotEmpty);
    expect(services.first.priceCents, greaterThan(0));
  });
}

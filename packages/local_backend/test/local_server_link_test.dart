import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:local_backend/local_backend.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  late LocalServer server;
  String? signedInAs;

  setUp(() async {
    signedInAs = 'demo';
    server = await startServer(holdDelay: const Duration(milliseconds: 20));
  });

  tearDown(() => server.dispose());

  LocalServerLink link({Duration networkDelay = Duration.zero}) =>
      LocalServerLink(
        server: server,
        currentUserId: () => signedInAs,
        networkDelay: networkDelay,
      );

  Request request(
    String document, [
    Map<String, dynamic> variables = const {},
  ]) => Request(
    operation: Operation(document: parseString(document)),
    variables: variables,
  );

  String? errorCode(Response response) =>
      response.errors?.single.extensions?['code'] as String?;

  test('answers a query with __typename on every object', () async {
    final Response response = await link()
        .request(request('query { __typename services { __typename id } }'))
        .single;

    expect(response.errors, isNull);
    expect(response.data!['__typename'], 'Query');
    final List<Object?> services = response.data!['services'] as List<Object?>;
    expect(services.first, containsPair('__typename', 'Service'));
  });

  test('resolves inline literal arguments as well as variables', () async {
    final Response literal = await link()
        .request(request('query { availableSlots(days: 2) { id } }'))
        .single;
    final Response variable = await link()
        .request(
          request(
            r'query Slots($days: Int!) { availableSlots(days: $days) { id } }',
            <String, dynamic>{'days': 2},
          ),
        )
        .single;

    expect(literal.data!['availableSlots'] as List<Object?>, hasLength(8));
    expect(variable.data, literal.data);
  });

  test('protected fields need a signed-in caller', () async {
    signedInAs = null;

    final Response response = await link()
        .request(request('query { paymentMethods { id } }'))
        .single;

    expect(errorCode(response), ErrorCodes.unauthenticated);
  });

  test('a field with no resolver is NOT_IMPLEMENTED', () async {
    final Response response = await link()
        .request(request('mutation { cancelOrder(id: "x") { id } }'))
        .single;

    expect(errorCode(response), ErrorCodes.notImplemented);
  });

  test('bad input is VALIDATION_FAILED, not a crash', () async {
    final Response response = await link()
        .request(request('query { availableSlots(days: 99) { id } }'))
        .single;

    expect(errorCode(response), ErrorCodes.validationFailed);
  });

  test('queries and mutations wait for the network delay first', () async {
    final Stopwatch stopwatch = Stopwatch()..start();
    await link(
      networkDelay: const Duration(milliseconds: 60),
    ).request(request('query { services { id } }')).single;

    expect(
      stopwatch.elapsed,
      greaterThanOrEqualTo(const Duration(milliseconds: 60)),
    );
  });

  test(
    'orderUpdated sends the current state first, then the change, then ends',
    () async {
      final CreateOrderResult created = await server.createOrder(
        userId: 'demo',
        input: orderInput(slotId: openSlots(server).first),
      );

      final List<Response> responses = await link()
          .request(
            request(
              r'subscription Watch($id: ID!) { orderUpdated(id: $id) { id status } }',
              <String, dynamic>{'id': created.order.id},
            ),
          )
          .toList();

      expect(
        responses.map(
          (Response response) =>
              (response.data!['orderUpdated']
                  as Map<String, Object?>)['status'],
        ),
        <String>['HOLD_PENDING', 'HOLD_PLACED'],
      );
    },
  );

  test("orderUpdated on someone else's order is NOT_FOUND", () async {
    final CreateOrderResult created = await server.createOrder(
      userId: 'someone-else',
      input: orderInput(slotId: openSlots(server).first),
    );

    final Response response = await link()
        .request(
          request(
            r'subscription Watch($id: ID!) { orderUpdated(id: $id) { id } }',
            <String, dynamic>{'id': created.order.id},
          ),
        )
        .single;

    expect(errorCode(response), ErrorCodes.notFound);
  });
}

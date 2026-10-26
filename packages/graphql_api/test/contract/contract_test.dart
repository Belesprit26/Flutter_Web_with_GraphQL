import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';
import 'package:test/test.dart';

// Every operation runs through a real ferry client, the real LocalServerLink
// and a fresh server, and has to come back as its generated type. This is
// what makes "no maps in app code" true rather than hoped for: if the server's
// maps drift from the schema, these fail with the field's name.
void main() {
  late LocalServer server;
  late Client client;

  setUp(() async {
    server = await LocalServer.start(
      store: InMemoryKeyValueStore(),
      holdDelay: const Duration(milliseconds: 20),
    );
    client = createGraphQLClient(
      link: LocalServerLink(server: server, currentUserId: () => 'demo'),
    );
  });

  tearDown(() async {
    await client.dispose();
    await server.dispose();
  });

  /// The server's answer, or the first error - a response that doesn't fit
  /// the generated types surfaces as an error, not as data.
  Future<TData> run<TData, TVars>(
    OperationRequest<TData, TVars> request,
  ) async {
    final OperationResponse<TData, TVars> response = await client
        .request(request)
        .firstWhere(
          (OperationResponse<TData, TVars> response) =>
              response.dataSource == DataSource.Link || response.hasErrors,
        );
    expect(
      response.hasErrors,
      isFalse,
      reason: '${response.graphqlErrors} ${response.linkException}',
    );
    return response.data as TData;
  }

  Future<GCreateOrderData_createOrder> createOrder() async {
    final GAvailableSlotsData slots = await run(
      GAvailableSlotsReq((b) => b..vars.days = 7),
    );
    final GCreateOrderData created = await run(
      GCreateOrderReq(
        (b) => b
          ..vars.input.idempotencyKey = 'key-1'
          ..vars.input.serviceIds.add('svc-regular-clean')
          ..vars.input.slotId = slots.availableSlots.first.id
          ..vars.input.paymentMethodId = 'pm-visa-4242',
      ),
    );
    return created.createOrder;
  }

  final List<({String operation, Future<void> Function() check})> cases =
      <({String operation, Future<void> Function() check})>[
        (
          operation: 'Services',
          check: () async {
            final GServicesData data = await run(GServicesReq());
            expect(data.services.first.priceCents, greaterThan(0));
          },
        ),
        (
          operation: 'AvailableSlots',
          check: () async {
            final GAvailableSlotsData data = await run(
              GAvailableSlotsReq((b) => b..vars.days = 7),
            );
            expect(data.availableSlots, hasLength(21));
          },
        ),
        (
          operation: 'PaymentMethods',
          check: () async {
            final GPaymentMethodsData data = await run(GPaymentMethodsReq());
            expect(data.paymentMethods, hasLength(3));
          },
        ),
        (
          operation: 'CreateOrder',
          check: () async {
            final GCreateOrderData_createOrder created = await createOrder();
            expect(created.order.status, GOrderStatus.HOLD_PENDING);
            expect(created.order.totalCents, 45000);
          },
        ),
        (
          operation: 'OrderDetails',
          check: () async {
            final GCreateOrderData_createOrder created = await createOrder();
            final GOrderDetailsData data = await run(
              GOrderDetailsReq((b) => b..vars.id = created.order.id),
            );
            expect(data.order!.card.last4, '4242');
          },
        ),
        (
          operation: 'OrderUpdated',
          check: () async {
            final GCreateOrderData_createOrder created = await createOrder();
            final List<GOrderStatus> statuses = await client
                .request(GOrderUpdatedReq((b) => b..vars.id = created.order.id))
                .where((response) => response.dataSource == DataSource.Link)
                .map((response) => response.data!.orderUpdated.status)
                .take(2)
                .toList();
            expect(statuses, <GOrderStatus>[
              GOrderStatus.HOLD_PENDING,
              GOrderStatus.HOLD_PLACED,
            ]);
          },
        ),
      ];

  for (final ({String operation, Future<void> Function() check}) contract
      in cases) {
    test(
      '${contract.operation} comes back as its generated type',
      contract.check,
    );
  }

  test(
    'a subscription result updates the watched OrderDetails query',
    () async {
      final GCreateOrderData_createOrder created = await createOrder();

      final Future<GOrderStatus?> placedSeenByQuery = client
          .request(GOrderDetailsReq((b) => b..vars.id = created.order.id))
          .map((response) => response.data?.order?.status)
          .firstWhere(
            (GOrderStatus? status) => status == GOrderStatus.HOLD_PLACED,
          );
      final subscription = client
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

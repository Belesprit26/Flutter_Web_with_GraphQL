import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';

/// A real ferry client on a real LocalServerLink over a fresh LocalServer, so
/// every contract test runs the real operation end to end.
class ContractHarness {
  ContractHarness._(this.server, this.client);

  static Future<ContractHarness> start({
    Duration holdDelay = const Duration(milliseconds: 20),
  }) async {
    final LocalServer server = await LocalServer.start(
      store: InMemoryKeyValueStore(),
      holdDelay: holdDelay,
    );
    final Client client = createGraphQLClient(
      link: LocalServerLink(server: server, currentUserId: () => 'demo'),
    );
    return ContractHarness._(server, client);
  }

  final LocalServer server;
  final Client client;

  /// The server's answer, or the first error. A response that doesn't fit
  /// the generated types surfaces as an error, not as data from the link.
  Future<OperationResponse<TData, TVars>> run<TData, TVars>(
    OperationRequest<TData, TVars> request,
  ) => client
      .request(request)
      .firstWhere(
        (OperationResponse<TData, TVars> response) =>
            response.dataSource == DataSource.Link || response.hasErrors,
      );

  /// Places an order through the real createOrder operation.
  /// Without [slotId] it books the first open slot. Pass the same slot to
  /// replay: once booked, that slot is no longer the first open one.
  Future<GCreateOrderData_createOrder> createOrder({
    String idempotencyKey = 'key-1',
    String paymentMethodId = 'pm-visa-4242',
    String? slotId,
  }) async {
    slotId ??= await _firstOpenSlot();
    final OperationResponse<GCreateOrderData, GCreateOrderVars> created =
        await run(
          GCreateOrderReq(
            (b) => b
              ..vars.input.idempotencyKey = idempotencyKey
              ..vars.input.serviceIds.add('svc-regular-clean')
              ..vars.input.slotId = slotId
              ..vars.input.paymentMethodId = paymentMethodId,
          ),
        );
    final GCreateOrderData? data = created.data;
    if (data == null) {
      throw StateError('createOrder failed: ${describeErrors(created)}');
    }
    return data.createOrder;
  }

  Future<String> _firstOpenSlot() async {
    final OperationResponse<GAvailableSlotsData, GAvailableSlotsVars> slots =
        await run(GAvailableSlotsReq((b) => b..vars.days = 7));
    return slots.data!.availableSlots
        .firstWhere((GAvailableSlotsData_availableSlots slot) => slot.available)
        .id;
  }

  Future<void> dispose() async {
    await client.dispose();
    await server.dispose();
  }
}

String describeErrors(OperationResponse<Object?, Object?> response) =>
    '${response.graphqlErrors} ${response.linkException}';

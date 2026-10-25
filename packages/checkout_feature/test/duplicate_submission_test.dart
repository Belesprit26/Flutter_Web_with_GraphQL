import 'package:checkout_feature/checkout_feature.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';

import 'support/fakes.dart';

// The headline test: no sequence of double clicks, lost answers, retries or
// reloads produces two orders for one intended checkout. Everything below the
// UI is real - the use case, the saved attempt, the ferry client, the link
// and the in-app server - so this proves the money rule across the layers.

const String user = 'demo';

void main() {
  // These two survive a "reload": the server's database and the browser's
  // storage. Everything else is rebuilt by boot().
  late InMemoryKeyValueStore serverStore;
  late InMemoryLocalStore deviceStore;
  late RecordingAppLogger logger;

  setUp(() {
    serverStore = InMemoryKeyValueStore();
    deviceStore = InMemoryLocalStore();
    logger = RecordingAppLogger();
  });

  Future<PageLoad> boot({bool loseFirstAnswer = false}) async {
    final PageLoad page = await PageLoad.boot(
      serverStore: serverStore,
      deviceStore: deviceStore,
      logger: logger,
      loseFirstAnswer: loseFirstAnswer,
    );
    addTearDown(page.dispose);
    return page;
  }

  Future<List<String>> orderIdsOnServer() async => <String>[
    for (final String key in (await serverStore.readAll(
      prefix: 'lb.v1.order.',
    )).keys)
      key.substring('lb.v1.order.'.length),
  ];

  test('(a) two confirms at the same moment make exactly one order', () async {
    final PageLoad page = await boot();
    final CheckoutRequest request = await page.request();

    final List<Result<Order>> results =
        await Future.wait(<Future<Result<Order>>>[
          page.placeOrder(userId: user, request: request),
          page.placeOrder(userId: user, request: request),
        ]);

    expect(results.map(orderIdOf).toSet(), hasLength(1));
    expect(await orderIdsOnServer(), hasLength(1));
    expect(logger.events, contains('checkout.duplicate_suppressed'));
  });

  test(
    '(b) a reload mid-confirm replays the same key and gets the same order',
    () async {
      final PageLoad first = await boot(loseFirstAnswer: true);
      final CheckoutRequest request = await first.request();

      final Result<Order> lost = await first.placeOrder(
        userId: user,
        request: request,
      );
      expect(lost, isA<Err<Order>>());
      expect((lost as Err<Order>).failure, isA<NetworkFailure>());
      // The server made the order; the client never heard about it.
      final List<String> made = await orderIdsOnServer();
      expect(made, hasLength(1));
      await first.dispose();

      // The reload: a new server over the same database, a new client and a
      // new use case over the same browser storage.
      final PageLoad second = await boot();
      final Result<Order>? resumed = await second.placeOrder.resume(
        userId: user,
      );

      expect(orderIdOf(resumed!), made.single);
      expect(await orderIdsOnServer(), made);
      expect(logger.events, contains('server.order.replayed'));
      expect(
        logger.entries.where(
          (LoggedEvent entry) =>
              entry.event == 'checkout.confirm.succeeded' &&
              entry.fields['replayed'] == true,
        ),
        hasLength(1),
      );
    },
  );

  test(
    '(c) clicking again after a lost answer replays instead of re-ordering',
    () async {
      final PageLoad page = await boot(loseFirstAnswer: true);
      final CheckoutRequest request = await page.request();

      await page.placeOrder(userId: user, request: request);
      final String keyAfterError = (await page.attempts.load(
        user,
      ))!.idempotencyKey;
      final Result<Order> retried = await page.placeOrder(
        userId: user,
        request: request,
      );

      expect(orderIdOf(retried), (await orderIdsOnServer()).single);
      expect((await page.attempts.load(user))!.idempotencyKey, keyAfterError);
    },
  );

  test(
    '(d) changing the slot after it was taken mints a new key and one order',
    () async {
      final PageLoad page = await boot();
      final List<Slot> open = await page.openSlots();
      final CheckoutRequest wanted = await page.request(slotId: open[0].id);
      // Someone else books that slot first.
      await page.bookAsSomeoneElse(open[0].id);

      final Result<Order> taken = await page.placeOrder(
        userId: user,
        request: wanted,
      );
      expect((taken as Err<Order>).failure, isA<SlotUnavailableFailure>());
      final CheckoutAttempt afterTaken = (await page.attempts.load(user))!;
      expect(afterTaken.state, CheckoutAttemptState.draft);

      final Result<Order> placed = await page.placeOrder(
        userId: user,
        request: await page.request(slotId: open[1].id),
      );

      expect(placed, isA<Ok<Order>>());
      expect(
        (await page.attempts.load(user))!.idempotencyKey,
        isNot(afterTaken.idempotencyKey),
      );
      expect(await orderIdsOnServer(), hasLength(2)); // theirs and ours
    },
  );

  test(
    '(e) "try again" after a declined hold is a new attempt with a new key',
    () async {
      final PageLoad page = await boot();
      final CheckoutRequest declining = await page.request(
        paymentMethodId: 'pm-visa-0002',
      );

      final Result<Order> first = await page.placeOrder(
        userId: user,
        request: declining,
      );
      final Order failed = await page.orders
          .watchOrder(orderIdOf(first))
          .map((Result<Order?> result) => (result as Ok<Order?>).value!)
          .firstWhere((Order order) => order.status.isTerminal);
      expect(failed.status, OrderStatus.holdFailed);
      final String firstKey = (await page.attempts.load(user))!.idempotencyKey;

      await page.placeOrder.abandon(userId: user);
      expect(
        (await page.attempts.load(user))!.state,
        CheckoutAttemptState.abandoned,
      );
      final Result<Order> second = await page.placeOrder(
        userId: user,
        request: declining,
      );

      expect(orderIdOf(second), isNot(failed.id));
      expect((await page.attempts.load(user))!.idempotencyKey, isNot(firstKey));
    },
  );
}

String orderIdOf(Result<Order> result) => result.fold(
  ok: (Order order) => order.id,
  err: (AppFailure failure) => fail('Expected an order, got $failure'),
);

/// Everything one page load builds, over storage that outlives it.
class PageLoad {
  PageLoad._({
    required this.server,
    required this.client,
    required this.catalog,
    required this.orders,
    required this.attempts,
    required this.placeOrder,
  });

  static Future<PageLoad> boot({
    required InMemoryKeyValueStore serverStore,
    required InMemoryLocalStore deviceStore,
    required RecordingAppLogger logger,
    required bool loseFirstAnswer,
  }) async {
    final LocalServer server = await LocalServer.start(
      store: serverStore,
      holdDelay: const Duration(milliseconds: 20),
      log: (String event, Map<String, Object?> fields) =>
          logger.log(event, fields: fields),
    );
    final Link serverLink = LocalServerLink(
      server: server,
      currentUserId: () => user,
    );
    final Client client = createGraphQLClient(
      link: loseFirstAnswer
          ? loseFirstCreateOrderAnswer(serverLink)
          : serverLink,
    );
    final FerryOrderRepository orders = FerryOrderRepository(
      client: client,
      logger: logger,
    );
    final LocalCheckoutAttemptStore attempts = LocalCheckoutAttemptStore(
      store: deviceStore,
      logger: logger,
    );
    return PageLoad._(
      server: server,
      client: client,
      catalog: FerryCatalogRepository(client: client, logger: logger),
      orders: orders,
      attempts: attempts,
      placeOrder: PlaceOrderUseCase(
        orders: orders,
        attempts: attempts,
        logger: logger,
      ),
    );
  }

  final LocalServer server;
  final Client client;
  final FerryCatalogRepository catalog;
  final FerryOrderRepository orders;
  final LocalCheckoutAttemptStore attempts;
  final PlaceOrderUseCase placeOrder;

  Future<List<Slot>> openSlots() async => (await catalog.availableSlots()).fold(
    ok: (List<Slot> slots) =>
        slots.where((Slot slot) => slot.available).toList(),
    err: (AppFailure failure) => fail('$failure'),
  );

  Future<CheckoutRequest> request({
    String? slotId,
    String paymentMethodId = 'pm-visa-4242',
  }) async => CheckoutRequest(
    serviceIds: const <String>['svc-regular-clean', 'svc-windows'],
    slotId: slotId ?? (await openSlots()).first.id,
    paymentMethodId: paymentMethodId,
  );

  Future<void> bookAsSomeoneElse(String slotId) async {
    final Client theirClient = createGraphQLClient(
      link: LocalServerLink(server: server, currentUserId: () => 'someone'),
    );
    final OperationResponse<GCreateOrderData, GCreateOrderVars> response =
        await theirClient
            .request(
              GCreateOrderReq(
                (b) => b
                  ..vars.input.idempotencyKey = 'their-key'
                  ..vars.input.serviceIds.add('svc-garden')
                  ..vars.input.slotId = slotId
                  ..vars.input.paymentMethodId = 'pm-visa-4242',
              ),
            )
            .firstWhere(
              (OperationResponse<GCreateOrderData, GCreateOrderVars> r) =>
                  r.dataSource == DataSource.Link || r.hasErrors,
            );
    expect(response.hasErrors, isFalse);
    await theirClient.dispose();
  }

  Future<void> dispose() async {
    await client.dispose();
    await server.dispose();
  }
}

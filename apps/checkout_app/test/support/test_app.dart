import 'package:checkout_app/router/app_router.dart';
import 'package:checkout_feature/checkout_feature.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';

class MemoryStore implements LocalStore {
  final Map<String, String> values = <String, String>{};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> remove(String key) async => values.remove(key);
}

/// The real router, screens and view models over the real in-app stack,
/// all in memory: what the app wires up at startup, minus device storage.
class TestApp {
  TestApp._(this.router, this.session);

  final GoRouter router;
  final SessionController session;

  String get location => router.routeInformationProvider.value.uri.toString();

  static Future<TestApp> start(
    WidgetTester tester, {
    Session? signedInAs,
    Duration holdDelay = const Duration(seconds: 2),
    ServerLog log = ignoreServerEvents,
  }) async {
    const AppLogger logger = ConsoleAppLogger();
    final MemoryStore device = MemoryStore();
    final SessionController session = SessionController(
      repository: LocalSessionRepository(store: device, logger: logger),
      initial: signedInAs,
    );
    final LocalServer server = await LocalServer.start(
      store: InMemoryKeyValueStore(),
      holdDelay: holdDelay,
      log: log,
    );
    final Client client = createGraphQLClient(
      link: LocalServerLink(
        server: server,
        currentUserId: () => session.userId,
      ),
    );
    final CatalogRepository catalog = FerryCatalogRepository(
      client: client,
      logger: logger,
    );
    final OrderRepository orders = FerryOrderRepository(
      client: client,
      logger: logger,
    );
    final CheckoutAttemptStore attempts = LocalCheckoutAttemptStore(
      store: device,
      logger: logger,
    );
    final PlaceOrderUseCase placeOrder = PlaceOrderUseCase(
      orders: orders,
      attempts: attempts,
      logger: logger,
    );

    final GoRouter router = buildRouter(
      session: session,
      viewModels: ViewModelFactories(
        catalog: (List<String> selected) =>
            CatalogViewModel(catalog: catalog, initiallySelected: selected),
        checkout: (CheckoutArgs args) => CheckoutViewModel(
          args: args,
          userId: session.userId!,
          catalog: catalog,
          placeOrder: placeOrder,
          attempts: attempts,
          logger: logger,
        ),
        orderDetails: (String orderId) => OrderDetailsViewModel(
          orderId: orderId,
          userId: session.userId!,
          orders: orders,
          placeOrder: placeOrder,
        ),
      ),
    );
    addTearDown(() async {
      router.dispose();
      await client.dispose();
      await server.dispose();
    });
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    return TestApp._(router, session);
  }
}

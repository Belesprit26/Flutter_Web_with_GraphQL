import 'package:ferry/ferry.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';

import 'config/app_config.dart';
import 'features/checkout/checkout.dart';
import 'router/app_router.dart';

/// The app's objects, made once with plain constructors. View models aren't
/// made here: each route creates its own and disposes it with the page.
///
/// Swapping the in-app server for a real endpoint is a change here: pass a
/// different Link to createGraphQLClient. Nothing else knows the server is
/// local.
GoRouter buildApp({
  required AppConfig config,
  required AppLogger logger,
  required LocalStore store,
  required SessionController session,
  required LocalServer server,
}) {
  final Client client = createGraphQLClient(
    link: LocalServerLink(
      server: server,
      currentUserId: () => session.userId,
      networkDelay: config.networkDelay,
    ),
  );
  // Signing out drops everything the last user loaded from the cache.
  session.addListener(() {
    if (!session.signedIn) {
      client.cache.clear();
    }
  });

  final CatalogRepository catalog = FerryCatalogRepository(
    client: client,
    logger: logger,
  );
  final OrderRepository orders = FerryOrderRepository(
    client: client,
    logger: logger,
  );
  final CheckoutAttemptStore attempts = LocalCheckoutAttemptStore(
    store: store,
    logger: logger,
  );
  // One instance for the whole app, so single-flight spans every page.
  final PlaceOrderUseCase placeOrder = PlaceOrderUseCase(
    orders: orders,
    attempts: attempts,
    logger: logger,
  );

  return buildRouter(
    session: session,
    viewModels: ViewModelFactories(
      catalog: (List<String> selected) =>
          CatalogViewModel(catalog: catalog, initiallySelected: selected),
      // The checkout and order routes are protected, so a session exists
      // whenever these run.
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
}

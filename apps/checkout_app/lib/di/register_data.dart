import 'package:checkout_feature/checkout_feature.dart';
import 'package:ferry/ferry.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';

import '../config/app_config.dart';

/// Swapping the in-app server for a real endpoint is this file: pass a
/// different Link to createGraphQLClient. Nothing else knows the server is
/// local.
void registerData(
  GetIt getIt, {
  required LocalServer server,
  required SessionRepository sessions,
  required SessionController session,
}) {
  final AppLogger logger = getIt<AppLogger>();
  final Client client = createGraphQLClient(
    link: LocalServerLink(
      server: server,
      currentUserId: () => session.userId,
      networkDelay: getIt<AppConfig>().networkDelay,
      log: (String event, Map<String, Object?> fields) =>
          logger.log(event, fields: fields),
    ),
  );
  // Signing out drops everything the last user loaded from the cache.
  session.addListener(() {
    if (!session.signedIn) {
      client.cache.clear();
    }
  });

  getIt
    ..registerSingleton<LocalServer>(server, dispose: (s) => s.dispose())
    ..registerSingleton<Client>(client, dispose: (c) => c.dispose())
    ..registerSingleton<SessionRepository>(sessions)
    ..registerLazySingleton<CatalogRepository>(
      () => FerryCatalogRepository(client: client, logger: logger),
    )
    ..registerLazySingleton<OrderRepository>(
      () => FerryOrderRepository(client: client, logger: logger),
    )
    ..registerLazySingleton<CheckoutAttemptStore>(
      () =>
          LocalCheckoutAttemptStore(store: getIt<LocalStore>(), logger: logger),
    );
}

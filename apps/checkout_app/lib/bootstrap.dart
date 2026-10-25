import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:local_backend/local_backend.dart';

import 'config/app_config.dart';
import 'di/register_dependencies.dart';
import 'di/service_locator.dart';
import 'platform/shared_prefs_store.dart';

/// Gets everything the first frame depends on ready before runApp: storage,
/// the restored session and the started server. Without this a signed-in
/// refresh of an order page would bounce through sign-in, and the first query
/// could reach a server that hadn't loaded its orders yet. It's a handful of
/// local reads, so startup stays quick.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Clean URLs, no #. Does nothing on mobile.
  usePathUrlStrategy();

  final AppConfig config = AppConfig.fromEnvironment();
  const AppLogger logger = ConsoleAppLogger();
  final SharedPrefsStore store = SharedPrefsStore();

  final LocalSessionRepository sessions = LocalSessionRepository(
    store: store,
    logger: logger,
  );
  final SessionController session = SessionController(
    repository: sessions,
    initial: await sessions.restore(),
  );

  final LocalServer server = await LocalServer.start(
    store: store,
    holdDelay: config.holdDelay,
    log: (String event, Map<String, Object?> fields) =>
        logger.log(event, fields: fields),
  );

  registerDependencies(
    getIt,
    config: config,
    logger: logger,
    store: store,
    sessions: sessions,
    session: session,
    server: server,
  );
}

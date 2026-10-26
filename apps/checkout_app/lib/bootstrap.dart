import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:local_backend/local_backend.dart';

import 'config/app_config.dart';
import 'dependencies.dart';
import 'features/checkout/checkout.dart';
import 'platform/shared_prefs_store.dart';

/// Gets everything the first frame depends on ready before runApp: storage,
/// the restored session and the started server. Without this a signed-in
/// refresh of an order page would bounce through sign-in, and the first query
/// could reach a server that hadn't loaded its orders yet.
Future<GoRouter> bootstrap() async {
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
  );

  return buildApp(
    config: config,
    logger: logger,
    store: store,
    session: session,
    server: server,
  );
}

import 'package:checkout_feature/checkout_feature.dart';
import 'package:get_it/get_it.dart';
import 'package:local_backend/local_backend.dart';

import '../config/app_config.dart';
import '../platform/shared_prefs_store.dart';
import 'register_core.dart';
import 'register_data.dart';
import 'register_domain.dart';
import 'register_presentation.dart';

/// One file per layer, registered in dependency order.
void registerDependencies(
  GetIt getIt, {
  required AppConfig config,
  required AppLogger logger,
  required SharedPrefsStore store,
  required SessionRepository sessions,
  required SessionController session,
  required LocalServer server,
}) {
  registerCore(getIt, config: config, logger: logger, store: store);
  registerData(getIt, server: server, sessions: sessions, session: session);
  registerDomain(getIt);
  registerPresentation(getIt, session: session);
}

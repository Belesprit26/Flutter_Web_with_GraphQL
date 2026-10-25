import 'package:checkout_feature/checkout_feature.dart';
import 'package:get_it/get_it.dart';
import 'package:local_backend/local_backend.dart';

import '../config/app_config.dart';
import '../platform/shared_prefs_store.dart';

void registerCore(
  GetIt getIt, {
  required AppConfig config,
  required AppLogger logger,
  required SharedPrefsStore store,
}) {
  getIt
    ..registerSingleton<AppConfig>(config)
    ..registerSingleton<AppLogger>(logger)
    ..registerSingleton<KeyValueStore>(store)
    ..registerSingleton<LocalStore>(store);
}

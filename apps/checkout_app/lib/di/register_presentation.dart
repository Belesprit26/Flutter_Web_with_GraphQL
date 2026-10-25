import 'package:checkout_feature/checkout_feature.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

void registerPresentation(GetIt getIt, {required SessionController session}) {
  getIt
    ..registerSingleton<SessionController>(session)
    ..registerSingleton<GoRouter>(buildRouter(session: session));
}

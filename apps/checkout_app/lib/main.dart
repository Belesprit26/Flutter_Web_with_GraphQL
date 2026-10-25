import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'di/service_locator.dart';

Future<void> main() async {
  await bootstrap();
  runApp(CheckoutApp(router: getIt<GoRouter>()));
}

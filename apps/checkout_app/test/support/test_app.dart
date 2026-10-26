import 'package:checkout_app/config/app_config.dart';
import 'package:checkout_app/dependencies.dart';
import 'package:checkout_app/features/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:local_backend/local_backend.dart';

import 'fakes.dart';

/// The app as startup builds it - the real composition root, router, screens
/// and in-app server - over in-memory storage.
class TestApp {
  TestApp._(this.router);

  final GoRouter router;

  String get location => router.routeInformationProvider.value.uri.toString();

  static Future<TestApp> start(
    WidgetTester tester, {
    Session? signedInAs,
    Duration holdDelay = const Duration(seconds: 2),
  }) async {
    const AppLogger logger = ConsoleAppLogger();
    final InMemoryLocalStore device = InMemoryLocalStore();
    final LocalServer server = await LocalServer.start(
      store: InMemoryKeyValueStore(),
      holdDelay: holdDelay,
    );
    final GoRouter router = buildApp(
      config: AppConfig(networkDelay: Duration.zero, holdDelay: holdDelay),
      logger: logger,
      store: device,
      session: SessionController(
        repository: LocalSessionRepository(store: device, logger: logger),
        initial: signedInAs,
      ),
      server: server,
    );
    addTearDown(() async {
      router.dispose();
      await server.dispose();
    });
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    return TestApp._(router);
  }
}

import 'package:checkout_app/router/app_router.dart';
import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

// Behaviour, not layout: the real router, the real redirect policy and the
// real session controller, checking that sign-in sends you back where you
// were going. The policy's branches are covered by redirect_policy_test.dart.

class MemorySessions implements SessionRepository {
  Session? stored;

  @override
  Future<Session?> restore() async => stored;

  @override
  Future<void> save(Session session) async => stored = session;

  @override
  Future<void> clear() async => stored = null;
}

void main() {
  late SessionController session;
  late GoRouter router;

  Future<void> start(WidgetTester tester, {Session? signedInAs}) async {
    session = SessionController(
      repository: MemorySessions(),
      initial: signedInAs,
    );
    router = buildRouter(session: session);
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  }

  String currentLocation() =>
      router.routeInformationProvider.value.uri.toString();

  testWidgets('an order link opened signed out goes through sign-in and back', (
    WidgetTester tester,
  ) async {
    await start(tester);

    router.go('/orders/ord-abc123');
    await tester.pumpAndSettle();
    expect(find.text('Sign in to continue to your order.'), findsOneWidget);

    await tester.tap(find.text('Continue as demo user'));
    await tester.pumpAndSettle();

    expect(currentLocation(), '/orders/ord-abc123');
    expect(find.text('Order ord-abc123'), findsOneWidget);
  });

  testWidgets('checkout comes back with its selection after sign-in', (
    WidgetTester tester,
  ) async {
    await start(tester);

    router.go('/checkout?services=svc-a,svc-b&slot=slot-20261026-0800');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue as demo user'));
    await tester.pumpAndSettle();

    expect(
      currentLocation(),
      '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
    );
  });

  testWidgets('signing out on a protected page goes to sign-in', (
    WidgetTester tester,
  ) async {
    await start(tester, signedInAs: Session.demo);
    router.go('/orders/ord-abc123');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(Uri.parse(currentLocation()).path, '/sign-in');
    expect(find.text('Sign in to continue to your order.'), findsOneWidget);
  });
}

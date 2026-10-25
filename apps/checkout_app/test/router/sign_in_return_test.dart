import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';

// Behaviour, not layout: the real router, redirect policy and session
// controller over the real in-app stack, checking that sign-in sends you back
// where you were going. The policy's branches are covered by
// redirect_policy_test.dart.
void main() {
  testWidgets('an order link opened signed out goes through sign-in and back', (
    WidgetTester tester,
  ) async {
    final TestApp app = await TestApp.start(tester);

    app.router.go('/orders/ord-abc123');
    await tester.pumpAndSettle();
    expect(find.text('Sign in to continue to your order.'), findsOneWidget);

    await tester.tap(find.text('Continue as demo user'));
    await tester.pumpAndSettle();

    expect(app.location, '/orders/ord-abc123');
    expect(find.byType(OrderDetailsScreen), findsOneWidget);
  });

  testWidgets('checkout comes back with its selection after sign-in', (
    WidgetTester tester,
  ) async {
    final TestApp app = await TestApp.start(tester);

    app.router.go('/checkout?services=svc-a,svc-b&slot=slot-20261026-0800');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue as demo user'));
    await tester.pumpAndSettle();

    expect(
      app.location,
      '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
    );
    expect(find.byType(CheckoutScreen), findsOneWidget);
  });

  testWidgets('signing out on a protected page goes to sign-in', (
    WidgetTester tester,
  ) async {
    final TestApp app = await TestApp.start(tester, signedInAs: Session.demo);
    app.router.go('/orders/ord-abc123');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(Uri.parse(app.location).path, '/sign-in');
    expect(find.text('Sign in to continue to your order.'), findsOneWidget);
  });
}

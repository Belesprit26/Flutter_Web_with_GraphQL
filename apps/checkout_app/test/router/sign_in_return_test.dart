import 'package:checkout_app/features/checkout/checkout.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';

// The real router and session over the real in-app stack: sign-in sends you
// back to the link you opened.
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
  });
}

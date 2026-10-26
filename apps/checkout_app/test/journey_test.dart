import 'package:checkout_app/features/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/test_app.dart';

// The whole journey through the real screens, view models and in-app server:
// pick two services, pick a slot, place the hold, watch it go from pending to
// placed. Behaviour, not layout - it finds things by what they say.
void main() {
  testWidgets('pick services, place a hold, see it go from pending to placed', (
    WidgetTester tester,
  ) async {
    final TestApp app = await TestApp.start(tester, signedInAs: Session.demo);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CheckboxListTile).at(0));
    await tester.tap(find.byType(CheckboxListTile).at(1));
    await tester.pump();
    expect(find.textContaining('2 selected'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(Uri.parse(app.location).path, '/checkout');

    await tester.tap(
      find
          .byWidgetPredicate(
            (Widget widget) =>
                widget is ChoiceChip && widget.onSelected != null,
          )
          .first,
    );
    await tester.pumpAndSettle();
    // The slot is in the URL now, and the same view model is still there.
    expect(Uri.parse(app.location).queryParameters['slot'], isNotNull);

    final Finder confirm = find.textContaining('Place hold');
    await tester.scrollUntilVisible(
      confirm,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(confirm);
    // The pending step animates forever, so pump time instead of settling.
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(Uri.parse(app.location).path, startsWith('/orders/ord-'));
    expect(find.text('Confirming hold'), findsOneWidget);
    expect(find.text('Waiting for your bank…'), findsOneWidget);

    // Past the 2 second hold: the server places it and pushes it down the
    // subscription. ferry's cache needs a real turn of the event loop before
    // the watched query re-emits, which fake test time never gives it, so let
    // a moment of real time pass.
    await tester.pump(const Duration(seconds: 3));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();

    expect(find.text('Confirming hold'), findsNothing);
    expect(find.text('Hold placed'), findsWidgets);
  });
}

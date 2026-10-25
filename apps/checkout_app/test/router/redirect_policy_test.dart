import 'package:checkout_app/router/app_router.dart';
import 'package:checkout_app/router/redirect_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String? redirect(String location, {required bool signedIn}) =>
      resolveRedirect(signedIn: signedIn, location: Uri.parse(location));

  /// The `from` a sign-in redirect carries, decoded.
  String? fromOf(String? signInLocation) =>
      Uri.parse(signInLocation!).queryParameters['from'];

  group('the root', () {
    test('goes to the catalogue, signed in or not', () {
      expect(redirect('/', signedIn: false), '/services');
      expect(redirect('/', signedIn: true), '/services');
    });
  });

  group('public pages', () {
    test('the catalogue and sign-in are open to everyone', () {
      expect(redirect('/services', signedIn: false), isNull);
      expect(redirect('/sign-in', signedIn: false), isNull);
    });

    test('an unknown page is left for the not-found page', () {
      expect(redirect('/nope', signedIn: false), isNull);
      expect(redirect('/nope', signedIn: true), isNull);
    });
  });

  group('protected pages while signed out', () {
    test('an order link goes to sign-in and remembers the order', () {
      final String? target = redirect('/orders/ord-abc123', signedIn: false);

      expect(Uri.parse(target!).path, '/sign-in');
      expect(fromOf(target), '/orders/ord-abc123');
    });

    test('checkout keeps its whole query through sign-in', () {
      final String? target = redirect(
        '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
        signedIn: false,
      );

      expect(Uri.parse(target!).path, '/sign-in');
      expect(
        fromOf(target),
        '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
      );
    });

    test('a trailing path under checkout is protected too', () {
      expect(
        Uri.parse(redirect('/checkout/x', signedIn: false)!).path,
        '/sign-in',
      );
    });
  });

  group('protected pages while signed in', () {
    test('open as they are', () {
      expect(redirect('/orders/ord-abc123', signedIn: true), isNull);
      expect(redirect('/checkout?services=svc-a', signedIn: true), isNull);
    });
  });

  group('sign-in while already signed in', () {
    test('goes back to where the user was heading', () {
      final String signIn = redirect('/orders/ord-abc123', signedIn: false)!;

      expect(redirect(signIn, signedIn: true), '/orders/ord-abc123');
    });

    test('returns to checkout with the selection intact', () {
      final String signIn = redirect(
        '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
        signedIn: false,
      )!;

      expect(
        redirect(signIn, signedIn: true),
        '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
      );
    });

    test('with nowhere to return to, goes to the catalogue', () {
      expect(redirect('/sign-in', signedIn: true), '/services');
    });
  });

  group('open redirects are refused', () {
    for (final String from in <String>[
      'https://evil.example',
      '//evil.example',
      r'/\evil.example',
      'javascript:alert(1)',
      'evil.example/orders/x',
      '/unknown-page',
      '/sign-in?from=/orders/x',
      '/orders/../admin',
      '/orders/a/b',
      '',
    ]) {
      test('from=$from goes to the catalogue', () {
        final String location = Uri(
          path: '/sign-in',
          queryParameters: <String, String>{'from': from},
        ).toString();

        expect(redirect(location, signedIn: true), '/services');
        expect(safeReturnLocation(from), isNull);
      });
    }
  });

  group('checkout locations', () {
    test('the selection round-trips through the URL', () {
      final String location = checkoutLocation(
        serviceIds: <String>['svc-a', 'svc-b'],
        slotId: 'slot-20261026-0800',
      );
      final Uri uri = Uri.parse(location);

      expect(
        location,
        '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800',
      );
      expect(parseServiceIds(uri.queryParameters['services']), <String>[
        'svc-a',
        'svc-b',
      ]);
      expect(uri.queryParameters['slot'], 'slot-20261026-0800');
    });

    test('empty and missing service lists parse to nothing', () {
      expect(parseServiceIds(null), isEmpty);
      expect(parseServiceIds(''), isEmpty);
      expect(parseServiceIds(' , '), isEmpty);
    });
  });
}

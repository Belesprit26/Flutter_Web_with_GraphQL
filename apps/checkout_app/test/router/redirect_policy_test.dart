import 'package:checkout_app/router/redirect_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String? redirect(String location, {required bool signedIn}) =>
      resolveRedirect(signedIn: signedIn, location: Uri.parse(location));

  const String checkout =
      '/checkout?services=svc-a,svc-b&slot=slot-20261026-0800';

  test('the root goes to the catalogue', () {
    expect(redirect('/', signedIn: false), '/services');
  });

  test('public and unknown pages are let through', () {
    expect(redirect('/services', signedIn: false), isNull);
    expect(redirect('/nope', signedIn: false), isNull);
  });

  test('a protected page while signed out goes to sign-in, query and all', () {
    final Uri target = Uri.parse(redirect(checkout, signedIn: false)!);

    expect(target.path, '/sign-in');
    expect(target.queryParameters['from'], checkout);
  });

  test('a protected page while signed in opens as it is', () {
    expect(redirect('/orders/ord-abc123', signedIn: true), isNull);
  });

  test('sign-in while signed in goes back to where the user was heading', () {
    final String signIn = redirect(checkout, signedIn: false)!;

    expect(redirect(signIn, signedIn: true), checkout);
  });

  test('sign-in with nowhere to return to goes to the catalogue', () {
    expect(redirect('/sign-in', signedIn: true), '/services');
  });

  test(
    'a refreshed sign-in URL that the browser shows decoded keeps the slot',
    () {
      expect(redirect('/sign-in?from=$checkout', signedIn: true), checkout);
    },
  );

  test('open redirects are refused', () {
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
      final String location = Uri(
        path: '/sign-in',
        queryParameters: <String, String>{'from': from},
      ).toString();
      expect(redirect(location, signedIn: true), '/services', reason: from);
    }
  });
}

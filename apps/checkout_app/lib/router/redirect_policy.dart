/// Where to send the user instead of [location], or null to let them through.
/// A pure function, so every branch is unit tested without widgets. It's
/// synchronous on purpose: an async redirect would stop Router.neglect from
/// replacing the history entry after a confirm.
String? resolveRedirect({required bool signedIn, required Uri location}) {
  final String path = location.path;

  if (path == '/' || path.isEmpty) {
    return '/services';
  }

  if (!signedIn && _isProtected(path)) {
    // The full location is kept, query included, so /checkout?services=a,b
    // survives the trip through sign-in.
    return Uri(
      path: '/sign-in',
      queryParameters: <String, String>{'from': location.toString()},
    ).toString();
  }

  if (signedIn && path == '/sign-in') {
    return returnLocationOf(location) ?? '/services';
  }

  return null;
}

/// Where a `/sign-in` location says to go back to, if it's safe.
///
/// Everything after `from=` is the return location. Flutter web can write
/// the URL back to the address bar decoded, which turns
/// `from=%2Fcheckout%3Fservices%3Da%26slot%3Dx` into
/// `from=/checkout?services=a&slot=x` - and a refresh then reads `slot` as a
/// separate parameter of the sign-in page. Taking the raw rest of the query
/// works for both forms, so the slot survives a refresh on sign-in.
String? returnLocationOf(Uri signIn) {
  const String prefix = 'from=';
  final String query = signIn.query;
  if (!query.startsWith(prefix)) {
    return safeReturnLocation(signIn.queryParameters['from']);
  }
  try {
    return safeReturnLocation(
      Uri.decodeComponent(query.substring(prefix.length)),
    );
  } on ArgumentError {
    return null; // A broken percent-encoding: ignore it.
  }
}

/// [from] if it's a page in this app, otherwise null. Stops
/// `/sign-in?from=https://evil.example` from becoming an open redirect.
String? safeReturnLocation(String? from) {
  if (from == null ||
      !from.startsWith('/') ||
      from.startsWith('//') ||
      from.contains(r'\')) {
    return null;
  }
  final Uri? uri = Uri.tryParse(from);
  if (uri == null ||
      uri.hasScheme ||
      uri.hasAuthority ||
      uri.pathSegments.contains('..') ||
      !_isReturnable(uri.path)) {
    return null;
  }
  return uri.toString();
}

bool _isProtected(String path) =>
    path == '/checkout' ||
    path.startsWith('/checkout/') ||
    path.startsWith('/orders/');

final RegExp _orderPath = RegExp(r'^/orders/[^/]+$');

bool _isReturnable(String path) =>
    path == '/services' || path == '/checkout' || _orderPath.hasMatch(path);

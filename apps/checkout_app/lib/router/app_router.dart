import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'redirect_policy.dart';

/// The app's URLs. Every page can be opened directly, refreshed and deep
/// linked; protected pages go through sign-in and come back. Screens don't
/// know about the router - they get callbacks, and navigation stays here.
GoRouter buildRouter({required SessionController session}) {
  VoidCallback? signOut() => session.signedIn ? session.signOut : null;

  return GoRouter(
    initialLocation: '/services',
    refreshListenable: session,
    redirect: (BuildContext context, GoRouterState state) =>
        resolveRedirect(signedIn: session.signedIn, location: state.uri),
    errorBuilder: (BuildContext context, GoRouterState state) =>
        NotFoundScreen(onHome: () => context.go('/services')),
    routes: <RouteBase>[
      GoRoute(path: '/', redirect: (_, _) => '/services'),
      GoRoute(
        path: '/services',
        builder: (BuildContext context, GoRouterState state) => CatalogScreen(
          onContinue: (List<String> serviceIds) =>
              context.go(checkoutLocation(serviceIds: serviceIds)),
          onSignOut: signOut(),
        ),
      ),
      GoRoute(
        path: '/checkout',
        builder: (BuildContext context, GoRouterState state) => CheckoutScreen(
          serviceIds: parseServiceIds(state.uri.queryParameters['services']),
          slotId: state.uri.queryParameters['slot'],
          onSignOut: signOut(),
        ),
      ),
      GoRoute(
        path: '/orders/:orderId',
        builder: (BuildContext context, GoRouterState state) =>
            OrderDetailsScreen(
              orderId: state.pathParameters['orderId']!,
              onSignOut: signOut(),
            ),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (BuildContext context, GoRouterState state) => SignInScreen(
          session: session,
          returnTo: safeReturnLocation(state.uri.queryParameters['from']),
        ),
      ),
    ],
  );
}

/// `/checkout?services=a,b&slot=x`. The selection lives in the URL, so a
/// refresh or a shared link restores it. Ids are slugs, so no escaping.
String checkoutLocation({required List<String> serviceIds, String? slotId}) {
  final String services = 'services=${serviceIds.join(',')}';
  return slotId == null
      ? '/checkout?$services'
      : '/checkout?$services&slot=$slotId';
}

List<String> parseServiceIds(String? raw) => <String>[
  for (final String id in (raw ?? '').split(','))
    if (id.trim().isNotEmpty) id.trim(),
];

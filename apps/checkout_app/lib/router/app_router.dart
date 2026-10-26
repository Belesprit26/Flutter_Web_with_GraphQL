import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'redirect_policy.dart';

/// How each page's view model gets made. The app wires these to its
/// dependency container; tests pass fakes.
class ViewModelFactories {
  const ViewModelFactories({
    required this.catalog,
    required this.checkout,
    required this.orderDetails,
  });

  final CatalogViewModel Function(List<String> selected) catalog;
  final CheckoutViewModel Function(CheckoutArgs args) checkout;
  final OrderDetailsViewModel Function(String orderId) orderDetails;
}

/// The app's URLs. Every page can be opened directly, refreshed and deep
/// linked; protected pages go through sign-in and come back. Screens don't
/// know about the router - they get callbacks, and navigation stays here.
GoRouter buildRouter({
  required SessionController session,
  required ViewModelFactories viewModels,
}) {
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
        builder: (BuildContext context, GoRouterState state) {
          final List<String> selected = parseServiceIds(
            state.uri.queryParameters['selected'],
          );
          return ViewModelHost<CatalogViewModel>(
            create: () => viewModels.catalog(selected),
            builder: (BuildContext context, CatalogViewModel viewModel) =>
                CatalogScreen(
                  viewModel: viewModel,
                  onContinue: (List<String> serviceIds) =>
                      context.go(checkoutLocation(serviceIds: serviceIds)),
                  onSignOut: signOut(),
                ),
          );
        },
      ),
      GoRoute(
        path: '/checkout',
        builder: (BuildContext context, GoRouterState state) {
          final List<String> serviceIds = parseServiceIds(
            state.uri.queryParameters['services'],
          );
          return ViewModelHost<CheckoutViewModel>(
            // Same services, same view model: picking a slot rewrites the
            // URL but keeps the page as it is.
            key: ValueKey<String>(([...serviceIds]..sort()).join(',')),
            create: () => viewModels.checkout((
              serviceIds: serviceIds,
              slotId: state.uri.queryParameters['slot'],
            )),
            builder: (BuildContext context, CheckoutViewModel viewModel) =>
                CheckoutScreen(
                  viewModel: viewModel,
                  // Replaces the checkout's history entry, so browser back
                  // from the order doesn't land on a form to submit again.
                  onOrderPlaced: (String orderId) => Router.neglect(
                    context,
                    () => context.go('/orders/$orderId'),
                  ),
                  onViewOrder: (String orderId) =>
                      context.go('/orders/$orderId'),
                  onChangeServices: (List<String> ids) =>
                      context.go('/services?selected=${ids.join(',')}'),
                  onSlotSelected: (String slotId) => Router.neglect(
                    context,
                    () => context.go(
                      checkoutLocation(
                        serviceIds: viewModel.serviceIds,
                        slotId: slotId,
                      ),
                    ),
                  ),
                  onSignOut: signOut(),
                ),
          );
        },
      ),
      GoRoute(
        path: '/orders/:orderId',
        builder: (BuildContext context, GoRouterState state) {
          final String orderId = state.pathParameters['orderId']!;
          return ViewModelHost<OrderDetailsViewModel>(
            key: ValueKey<String>(orderId),
            create: () => viewModels.orderDetails(orderId),
            builder: (BuildContext context, OrderDetailsViewModel viewModel) =>
                OrderDetailsScreen(
                  viewModel: viewModel,
                  onTryAgain: (List<String> serviceIds) =>
                      context.go(checkoutLocation(serviceIds: serviceIds)),
                  onBrowse: () => context.go('/services'),
                  onSignOut: signOut(),
                ),
          );
        },
      ),
      GoRoute(
        path: '/sign-in',
        builder: (BuildContext context, GoRouterState state) => SignInScreen(
          session: session,
          returnTo: returnLocationOf(state.uri),
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

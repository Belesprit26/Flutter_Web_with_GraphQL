import 'package:flutter/material.dart';

import 'shared/app_page.dart';

// Bare pages so every route can be opened, deep linked and refreshed while
// the routing is built. The real screens replace these.

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({required this.onContinue, this.onSignOut, super.key});

  final void Function(List<String> serviceIds) onContinue;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Services',
    onSignOut: onSignOut,
    body: Center(
      child: FilledButton(
        onPressed: () =>
            onContinue(const <String>['svc-regular-clean', 'svc-windows']),
        child: const Text('Continue with 2 services'),
      ),
    ),
  );
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    required this.serviceIds,
    required this.slotId,
    this.onSignOut,
    super.key,
  });

  final List<String> serviceIds;
  final String? slotId;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Checkout',
    onSignOut: onSignOut,
    body: Center(
      child: Text('Checkout: ${serviceIds.join(', ')} · slot ${slotId ?? '-'}'),
    ),
  );
}

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({required this.orderId, this.onSignOut, super.key});

  final String orderId;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Order',
    onSignOut: onSignOut,
    body: Center(child: SelectableText('Order $orderId')),
  );
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({required this.onHome, super.key});

  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Not found',
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("This page doesn't exist."),
          const SizedBox(height: 16),
          FilledButton(onPressed: onHome, child: const Text('Browse services')),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import '../../domain/entities/order.dart';
import '../formatting/formatting.dart';
import '../shared/app_page.dart';
import '../shared/state_views.dart';
import 'order_details_view_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    required this.viewModel,
    required this.onTryAgain,
    required this.onBrowse,
    this.onSignOut,
    super.key,
  });

  final OrderDetailsViewModel viewModel;

  /// After a decline: back to checkout with the same services.
  final void Function(List<String> serviceIds) onTryAgain;
  final VoidCallback onBrowse;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Order',
      onSignOut: onSignOut,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, _) => switch (viewModel.state) {
          OrderLoading() => const LoadingView(),
          OrderMissing() => MessageView(
            message:
                "We couldn't find that order for this account in this "
                'browser. Orders are kept in the browser they were placed in.',
            actionLabel: 'Browse services',
            onAction: onBrowse,
          ),
          OrderLoadFailed(:final failure) => FailureView(
            failure: failure,
            onRetry: viewModel.retry,
          ),
          OrderLoaded(:final Order order) => _OrderView(
            order: order,
            stillConfirming: viewModel.stillConfirming,
            onTryAgain: () async => onTryAgain(await viewModel.startOver()),
            onBrowse: onBrowse,
          ),
        },
      ),
    );
  }
}

class _OrderView extends StatelessWidget {
  const _OrderView({
    required this.order,
    required this.stillConfirming,
    required this.onTryAgain,
    required this.onBrowse,
  });

  final Order order;
  final bool stillConfirming;
  final VoidCallback onTryAgain;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return SelectionArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Order ${order.shortId}', style: text.titleLarge),
              ),
              Chip(label: Text(order.status.label)),
            ],
          ),
          const SizedBox(height: 16),
          _Timeline(order: order),
          if (stillConfirming && order.status == OrderStatus.holdPending)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Still confirming - it's safe to leave this page. The result "
                'will be here when you come back.',
              ),
            ),
          if (order.status == OrderStatus.holdFailed) ...<Widget>[
            const SizedBox(height: 16),
            FilledButton(onPressed: onTryAgain, child: const Text('Try again')),
          ],
          const Divider(height: 32),
          ListTile(title: const Text('When'), subtitle: Text(order.slot.label)),
          ListTile(
            title: const Text('Card'),
            subtitle: Text(order.card.maskedNumber),
          ),
          for (final OrderItem item in order.items)
            ListTile(
              title: Text(item.name),
              trailing: Text(item.price.formatted),
            ),
          ListTile(
            title: Text('Total', style: text.titleMedium),
            trailing: Text(order.total.formatted, style: text.titleMedium),
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: onBrowse, child: const Text('Browse services')),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final bool pending = order.status == OrderStatus.holdPending;
    return Column(
      children: <Widget>[
        for (final OrderEvent event in order.timeline)
          ListTile(
            leading: _icon(event, pending: pending),
            title: Text(event.type.label),
            subtitle: Text(
              <String>[
                if (event.message != null) event.message!,
                '${event.at.sastTime} SAST',
              ].join('\n'),
            ),
          ),
        if (pending)
          const ListTile(
            leading: Icon(Icons.radio_button_unchecked),
            title: Text('Hold placed'),
            subtitle: Text('Waiting for your bank…'),
          ),
      ],
    );
  }

  Widget _icon(OrderEvent event, {required bool pending}) {
    if (event.type == OrderEventType.holdRequested && pending) {
      return const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (event.type == OrderEventType.holdFailed) {
      return const Icon(Icons.cancel_outlined);
    }
    return const Icon(Icons.check_circle_outline);
  }
}

import 'package:flutter/material.dart';

import 'package:checkout_app/core/result.dart';
import '../../domain/entities/catalog.dart';
import '../../domain/entities/order.dart';
import '../formatting/formatting.dart';
import '../shared/app_page.dart';
import '../shared/state_views.dart';
import 'checkout_view_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    required this.viewModel,
    required this.onOrderPlaced,
    required this.onViewOrder,
    required this.onChangeServices,
    required this.onSlotSelected,
    this.onSignOut,
    super.key,
  });

  final CheckoutViewModel viewModel;

  /// A confirm (or a resumed one) produced this order.
  final void Function(String orderId) onOrderPlaced;
  final void Function(String orderId) onViewOrder;
  final void Function(List<String> serviceIds) onChangeServices;

  /// So the URL can carry the slot and a refresh keeps it.
  final void Function(String slotId) onSlotSelected;
  final VoidCallback? onSignOut;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_openPlacedOrder);
  }

  @override
  void didUpdateWidget(CheckoutScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != widget.viewModel) {
      oldWidget.viewModel.removeListener(_openPlacedOrder);
      widget.viewModel.addListener(_openPlacedOrder);
    }
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_openPlacedOrder);
    super.dispose();
  }

  void _openPlacedOrder() {
    final String? orderId = widget.viewModel.takeOrderToOpen();
    if (orderId != null) {
      widget.onOrderPlaced(orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CheckoutViewModel viewModel = widget.viewModel;
    return AppPage(
      title: 'Checkout',
      onSignOut: widget.onSignOut,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, _) => switch (viewModel.phase) {
          CheckoutPhase.loading => const LoadingView(),
          CheckoutPhase.resuming => const LoadingView(
            message: 'Finishing your checkout…',
          ),
          CheckoutPhase.loadFailed => FailureView(
            failure: viewModel.loadFailure!,
            onRetry: viewModel.retry,
          ),
          CheckoutPhase.alreadyPlaced => MessageView(
            message: 'This order was already placed.',
            actionLabel: 'View order',
            onAction: () => widget.onViewOrder(viewModel.alreadyPlacedOrderId!),
          ),
          CheckoutPhase.ready => _CheckoutForm(
            viewModel: viewModel,
            onChangeServices: widget.onChangeServices,
            onSlotSelected: widget.onSlotSelected,
          ),
        },
      ),
    );
  }
}

class _CheckoutForm extends StatelessWidget {
  const _CheckoutForm({
    required this.viewModel,
    required this.onChangeServices,
    required this.onSlotSelected,
  });

  final CheckoutViewModel viewModel;
  final void Function(List<String> serviceIds) onChangeServices;
  final void Function(String slotId) onSlotSelected;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final Result<Order>? confirmResult = viewModel.confirm.result;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        if (viewModel.notice != null) ...<Widget>[
          Text(
            viewModel.notice!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: <Widget>[
            Expanded(child: Text('Your services', style: text.titleMedium)),
            TextButton(
              onPressed: () => onChangeServices(viewModel.serviceIds),
              child: const Text('Change'),
            ),
          ],
        ),
        if (!viewModel.hasValidServices)
          const Text('Pick one or two services to continue.'),
        for (final Service service in viewModel.services)
          ListTile(
            title: Text(service.name),
            subtitle: Text(service.duration.formatted),
            trailing: Text(service.price.formatted),
          ),
        const Divider(height: 32),
        Text('Pick a time (SAST)', style: text.titleMedium),
        const SizedBox(height: 8),
        for (final MapEntry<DateTime, List<Slot>> day in _slotsByDay(
          viewModel.slots,
        ).entries) ...<Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Text(day.value.first.startsAt.sastDay),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final Slot slot in day.value)
                ChoiceChip(
                  label: Text(slot.timeRange),
                  selected: slot.id == viewModel.selectedSlotId,
                  onSelected: slot.available
                      ? (_) {
                          viewModel.selectSlot(slot.id);
                          onSlotSelected(slot.id);
                        }
                      : null,
                ),
            ],
          ),
        ],
        const Divider(height: 32),
        Text('Pay with', style: text.titleMedium),
        for (final PaymentMethod card in viewModel.cards)
          ListTile(
            leading: Icon(
              card.id == viewModel.selectedCardId
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
            ),
            title: Text(card.maskedNumber),
            subtitle: Text('${card.label} · ${card.expiry}'),
            onTap: () => viewModel.selectCard(card.id),
          ),
        const Divider(height: 32),
        Row(
          children: <Widget>[
            Expanded(child: Text('Estimated total', style: text.titleMedium)),
            Text(viewModel.estimatedTotal.formatted, style: text.titleMedium),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "We'll ask your bank to hold this amount. Nothing is charged until "
          'the service is done.',
        ),
        const SizedBox(height: 16),
        if (confirmResult case Err<Order>(:final failure)) ...<Widget>[
          Text(
            failure.userMessage,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 8),
        ],
        FilledButton(
          onPressed: viewModel.canConfirm ? viewModel.confirm.execute : null,
          child: viewModel.confirm.running
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('Place hold · ${viewModel.estimatedTotal.formatted}'),
        ),
      ],
    );
  }

  Map<DateTime, List<Slot>> _slotsByDay(List<Slot> slots) {
    final Map<DateTime, List<Slot>> days = <DateTime, List<Slot>>{};
    for (final Slot slot in slots) {
      days.putIfAbsent(slot.startsAt.sastDate, () => <Slot>[]).add(slot);
    }
    return days;
  }
}

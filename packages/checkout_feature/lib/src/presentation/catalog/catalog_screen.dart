import 'package:flutter/material.dart';

import '../../core/result.dart';
import '../../domain/entities/catalog.dart';
import '../formatting/formatting.dart';
import '../shared/app_page.dart';
import '../shared/state_views.dart';
import 'catalog_view_model.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({
    required this.viewModel,
    required this.onContinue,
    this.onSignOut,
    super.key,
  });

  final CatalogViewModel viewModel;
  final void Function(List<String> serviceIds) onContinue;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Services',
      onSignOut: onSignOut,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (BuildContext context, _) {
          final Result<List<Service>>? result = viewModel.load.result;
          if (result == null) {
            return const LoadingView();
          }
          if (result case Err<List<Service>>(:final failure)) {
            return FailureView(
              failure: failure,
              onRetry: viewModel.load.execute,
            );
          }
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: <Widget>[
                    Text(
                      'Pick one or two services',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    for (final Service service in viewModel.services)
                      CheckboxListTile(
                        value: viewModel.isSelected(service.id),
                        onChanged: viewModel.canToggle(service.id)
                            ? (_) => viewModel.toggle(service.id)
                            : null,
                        title: Text(service.name),
                        subtitle: Text(
                          '${service.description}\n${service.duration.formatted}',
                        ),
                        isThreeLine: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        secondary: Text(service.price.formatted),
                      ),
                  ],
                ),
              ),
              _SelectionBar(viewModel: viewModel, onContinue: onContinue),
            ],
          );
        },
      ),
    );
  }
}

class _SelectionBar extends StatelessWidget {
  const _SelectionBar({required this.viewModel, required this.onContinue});

  final CatalogViewModel viewModel;
  final void Function(List<String> serviceIds) onContinue;

  @override
  Widget build(BuildContext context) {
    final int count = viewModel.selectedIds.length;
    return Material(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                count == 0
                    ? 'Nothing selected yet'
                    : '$count selected · ${viewModel.estimatedTotal.formatted} estimated',
              ),
            ),
            FilledButton(
              onPressed: viewModel.canContinue
                  ? () => onContinue(viewModel.selectedIds)
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';

/// Creates a view model when its page appears and disposes it when the page
/// goes. Give it a key made of whatever identifies the page - an order id, a
/// set of services - so a new identity gets a new view model, while other URL
/// changes (picking a slot) keep the one it has.
class ViewModelHost<T extends ChangeNotifier> extends StatefulWidget {
  const ViewModelHost({required this.create, required this.builder, super.key});

  final T Function() create;
  final Widget Function(BuildContext context, T viewModel) builder;

  @override
  State<ViewModelHost<T>> createState() => _ViewModelHostState<T>();
}

class _ViewModelHostState<T extends ChangeNotifier>
    extends State<ViewModelHost<T>> {
  late final T _viewModel = widget.create();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _viewModel);
}

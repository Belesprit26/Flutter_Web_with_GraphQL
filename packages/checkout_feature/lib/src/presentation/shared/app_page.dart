import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// The frame every page shares: the browser tab title, the brand app bar
/// and, when someone is signed in, a sign-out action.
class AppPage extends StatelessWidget {
  const AppPage({
    required this.title,
    required this.body,
    this.onSignOut,
    super.key,
  });

  /// The page's name for the browser tab, e.g. "Checkout".
  final String title;
  final Widget body;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) {
    return Title(
      title: pageTitle(title),
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(brandName),
          actions: <Widget>[
            if (onSignOut != null)
              TextButton(onPressed: onSignOut, child: const Text('Sign out')),
          ],
        ),
        body: SafeArea(child: body),
      ),
    );
  }
}

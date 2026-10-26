import 'package:flutter/material.dart';

import '../../domain/entities/session.dart';
import '../session/session_controller.dart';
import '../shared/app_page.dart';

/// Simulated sign-in: no passwords, one tap. Where to go next is the
/// router's job - it watches the session.
class SignInScreen extends StatelessWidget {
  const SignInScreen({required this.session, this.returnTo, super.key});

  final SessionController session;

  /// The page the user was trying to open, if any.
  final String? returnTo;

  String get _reason {
    final String? returnTo = this.returnTo;
    if (returnTo == null) {
      return 'Sign in to book and see your orders.';
    }
    return returnTo.startsWith('/orders/')
        ? 'Sign in to continue to your order.'
        : 'Sign in to continue to checkout.';
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Sign in',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(_reason),
                const SizedBox(height: 24),
                FilledButton(
                  autofocus: true,
                  onPressed: () => session.signIn(Session.demo),
                  child: const Text('Continue as demo user'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

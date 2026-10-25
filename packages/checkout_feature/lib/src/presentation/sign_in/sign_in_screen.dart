import 'package:flutter/material.dart';

import '../../domain/entities/session.dart';
import '../session/session_controller.dart';
import '../shared/app_page.dart';

/// Simulated sign-in: no passwords. "Continue as demo user" is one tap with a
/// consistent id; another name shows that orders belong to their owner.
/// Where to go next is the router's job - it watches the session.
class SignInScreen extends StatefulWidget {
  const SignInScreen({required this.session, this.returnTo, super.key});

  final SessionController session;

  /// The page the user was trying to open, if any.
  final String? returnTo;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _name = TextEditingController();
  String? _nameError;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String get _reason {
    final String? returnTo = widget.returnTo;
    if (returnTo == null) {
      return 'Sign in to book and see your orders.';
    }
    return returnTo.startsWith('/orders/')
        ? 'Sign in to continue to your order.'
        : 'Sign in to continue to checkout.';
  }

  Future<void> _signInWithName() async {
    final Session? session = Session.forName(_name.text);
    if (session == null) {
      setState(() => _nameError = 'Enter a name with at least one letter.');
      return;
    }
    await widget.session.signIn(session);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Sign in',
      body: Center(
        child: SingleChildScrollView(
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
                  onPressed: () => widget.session.signIn(Session.demo),
                  child: const Text('Continue as demo user'),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'Or use another name',
                    errorText: _nameError,
                  ),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (_) => _signInWithName(),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _signInWithName,
                  child: const Text('Continue with this name'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

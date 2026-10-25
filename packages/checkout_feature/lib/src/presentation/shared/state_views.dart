import 'package:flutter/material.dart';

import '../../core/app_failure.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(),
          if (message != null) ...<Widget>[
            const SizedBox(height: 16),
            Text(message!),
          ],
        ],
      ),
    );
  }
}

/// Shows the failure's user message - never the developer detail.
class FailureView extends StatelessWidget {
  const FailureView({required this.failure, this.onRetry, super.key});

  final AppFailure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return MessageView(
      message: failure.userMessage,
      actionLabel: onRetry == null ? null : 'Try again',
      onAction: onRetry,
    );
  }
}

class MessageView extends StatelessWidget {
  const MessageView({
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message, textAlign: TextAlign.center),
            if (actionLabel != null) ...<Widget>[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

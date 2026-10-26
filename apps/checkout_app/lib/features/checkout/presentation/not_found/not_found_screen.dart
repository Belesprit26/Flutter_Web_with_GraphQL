import 'package:flutter/material.dart';

import '../shared/app_page.dart';
import '../shared/state_views.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({required this.onHome, super.key});

  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Not found',
    body: MessageView(
      message: "This page doesn't exist.",
      actionLabel: 'Browse services',
      onAction: onHome,
    ),
  );
}

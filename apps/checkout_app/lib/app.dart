import 'package:checkout_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: brandName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}

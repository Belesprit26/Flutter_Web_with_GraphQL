import 'package:flutter/material.dart';

void main() {
  runApp(const CheckoutApp());
}

// Placeholder until the router and screens land.
class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Brightnook',
      home: Scaffold(body: Center(child: Text('Brightnook'))),
    );
  }
}

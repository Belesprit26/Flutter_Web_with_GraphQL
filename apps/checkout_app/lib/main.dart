import 'package:flutter/widgets.dart';

import 'app.dart';
import 'bootstrap.dart';

Future<void> main() async {
  runApp(CheckoutApp(router: await bootstrap()));
}

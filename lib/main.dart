import 'package:api/core/logic/helper.dart';
import 'package:api/themar_screens/contuct_us/view.dart';
import 'package:api/themar_screens/view.dart';
import 'package:flutter/material.dart';

import 'service_locator.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const Views());
  }
}

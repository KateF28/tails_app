import 'package:flutter/material.dart';

import 'package:tails_app/tails_material_app.dart';
import 'package:tails_app/data/datasources/local/locale_provider.dart';

void main() {
  runApp(const MyApp());
}

/// This is main App widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LocaleProvider(
      child: const TailsMaterialApp(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/tails_material_app.dart';
import 'package:tails_app/data/datasources/local/locale_notifier.dart';

void main() {
  runApp(const MyApp());
}

/// This is main App widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleNotifier>(
      create: (_) => LocaleNotifier(const Locale('uk', 'UA')),
      child: const TailsMaterialApp(),
    );
  }
}

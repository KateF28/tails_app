import 'package:flutter/material.dart';
import 'package:tails_app/main_screen.dart';
import 'package:tails_app/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

/// This is main App widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tails App',
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: bgColor),
      home: const MainScreen(),
    );
  }
}

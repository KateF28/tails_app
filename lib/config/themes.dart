import 'package:flutter/material.dart';
import 'package:tails_app/utils/environment.dart';

class AppTheme {
  static const _colorSchemeSeed = Color(0xFF7950F2);
  static const bool _useMaterial3 = true;

  late final ThemeData _lightTheme;
  late final ThemeData _darkTheme;

  AppTheme() {
    _lightTheme = ThemeData(
      useMaterial3: _useMaterial3,
      colorSchemeSeed: _colorSchemeSeed,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Environment.bgColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _darkTheme = ThemeData(
      useMaterial3: _useMaterial3,
      colorSchemeSeed: _colorSchemeSeed,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: _colorSchemeSeed,
      ),
    );
  }

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
}

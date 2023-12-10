import 'package:flutter/material.dart';

/// Constant values
class Environment {
  /// Remote API
  static const String host = 'https://api.thedogapi.com/v1/';
  static const String breeds = 'breeds';
  static const String apiKey =
      'live_C3AM2eeC4n9hFHn9JrgdQgwjU9IZouBURHJ4J64z95afLiOhjsEqFsIiZzRP7hPq';

  /// Colors:
  static const whiteColor = Colors.white;
  static const textColor = Color(0xFF7950f2);
  static const bgColor = Color(0xFFF3F0FF);
  static Color dialogBgColor = Colors.black12.withOpacity(0.87);
  static const Color errorColor = Colors.red;

  /// Duration:
  static const transitionDuration = Duration(milliseconds: 300);
}

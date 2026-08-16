import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light(Color accent) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: accent,
        secondary: const Color(0xFF006D77),
        tertiary: const Color(0xFF264653),
      ),
    );
  }

  static ThemeData dark(Color accent) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: accent,
        secondary: const Color(0xFF83C5BE),
        tertiary: const Color(0xFFA8DADC),
      ),
    );
  }
}

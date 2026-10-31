import 'package:flutter/material.dart';

import 'brand.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light(Color accent) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: accent,
        secondary: Brand.violeta,
        tertiary: Brand.tinta,
      ),
    );
  }

  static ThemeData dark(Color accent) {
    final scheme = ColorScheme.dark(
      primary: accent,
      onPrimary: Brand.tinta,
      secondary: Brand.villaVioleta,
      tertiary: Brand.lima,
      surface: Brand.campo,
      onSurface: Brand.crema,
      surfaceContainerHighest: Brand.tarjeta,
      outline: Brand.limaBorde,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: Brand.campo,
      appBarTheme: const AppBarTheme(
        backgroundColor: Brand.campo,
        foregroundColor: Brand.crema,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Brand.tarjeta,
        indicatorColor: Brand.lima.withValues(alpha: 0.16),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? Brand.lima : Brand.crema.withValues(alpha: 0.7),
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Brand.lima,
          foregroundColor: Brand.tinta,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

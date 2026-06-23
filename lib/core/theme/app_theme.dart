import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const _lightColors = LightAppColors();
  static const _darkColors = DarkAppColors();

  static ThemeData get light {
    return _themeData(colors: _lightColors, brightness: Brightness.light);
  }

  static ThemeData get dark {
    return _themeData(colors: _darkColors, brightness: Brightness.dark);
  }

  static ThemeData _themeData({
    required AppColors colors,
    required Brightness brightness,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colors.surface,
        foregroundColor: colors.text,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

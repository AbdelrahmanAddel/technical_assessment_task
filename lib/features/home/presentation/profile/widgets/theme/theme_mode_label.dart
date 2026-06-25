import 'package:flutter/material.dart';

import 'package:flutter_techincal_test/core/constant/app_strings.dart';

String themeModeLabel(ThemeMode mode) {
  return switch (mode) {
    ThemeMode.light => AppStrings.lightTheme,
    ThemeMode.dark => AppStrings.darkTheme,
    ThemeMode.system => AppStrings.systemTheme,
  };
}

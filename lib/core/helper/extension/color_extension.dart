import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/theme/app_colors.dart';

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

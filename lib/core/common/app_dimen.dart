import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppDimension {
  static double get placeholderOuterPadding => 24.w;
  static double get placeholderInnerPadding => 24.w;
  static double get placeholderBorderRadius => 12.r;
  static double get placeholderTitleSpacing => 8.h;
  static const placeholderSubtitleAlpha = 0.72;

  static double get bottomNavHorizontalPadding => 8.w;
  static double get bottomNavVerticalPadding => 8.h;
  static double get bottomNavItemBorderRadius => 12.r;
  static double get bottomNavItemVerticalPadding => 8.h;
  static double get bottomNavIconSize => 24.r;
  static double get bottomNavLabelSpacing => 4.h;
  static const bottomNavUnselectedAlpha = 0.55;
}

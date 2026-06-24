import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AuthDimension {
  static double get scaffoldMaxWidth => 500.w;
  static double get scaffoldOuterHorizontalPadding => 16.w;
  static double get scaffoldOuterVerticalPadding => 24.h;
  static double get scaffoldInnerPadding => 20.w;
  static BorderRadius get scaffoldBorderRadius => BorderRadius.circular(16.r);
  static double get scaffoldShadowBlur => 28.r;
  static double get scaffoldShadowOffsetY => 16.h;

  static const otpLength = 6;
  static const otpFieldSpacing = 4.0;
  static const otpFieldBorderWidth = 1.0;

  static double get otpFieldHeight => 48.h;

  static BorderRadius get otpFieldBorderRadius => BorderRadius.circular(10.r);

  static EdgeInsets get otpFieldMargin =>
      const EdgeInsets.only(right: otpFieldSpacing);

  static double otpFieldWidth(double maxWidth) {
    final totalMargin = otpFieldSpacing * otpLength;
    return (maxWidth - totalMargin) / otpLength;
  }

  static double get emailTopSpacing => 12.h;
  static double get otpTopSpacing => 28.h;
  static double get verifyButtonTopSpacing => 24.h;
}

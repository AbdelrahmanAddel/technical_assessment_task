import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppTextStyles {
  static TextStyle headline({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      height: 1.2,
    );
  }

  static TextStyle title({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      height: 1.25,
    );
  }

  static TextStyle body({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      height: 1.45,
    );
  }

  static TextStyle button({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 15.sp,
      fontWeight: FontWeight.w700,
      height: 1.2,
    );
  }

  static TextStyle caption({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      height: 1.35,
    );
  }
}

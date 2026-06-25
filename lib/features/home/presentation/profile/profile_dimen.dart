import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class ProfileDimension {
  static double get horizontalPadding => 16.w;
  static double get verticalPadding => 16.h;
  static double get headerCardRadius => 20.r;
  static double get headerCardPadding => 24.w;
  static double get avatarSize => 96.r;
  static double get avatarBorderWidth => 3.w;
  static double get nameTopSpacing => 16.h;
  static double get emailTopSpacing => 6.h;
  static double get sectionTopSpacing => 24.h;
  static double get infoCardRadius => 16.r;
  static double get infoCardPadding => 16.w;
  static double get infoRowSpacing => 12.h;
  static double get infoIconSize => 20.r;
  static double get infoIconBoxSize => 40.r;
  static double get logoutTopSpacing => 32.h;
  static const headerGradientAlpha = 0.08;
  static const subtitleAlpha = 0.65;
  static const avatarPlaceholderIconAlpha = 0.4;
}

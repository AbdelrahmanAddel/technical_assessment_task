import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class HomeDimension {
  static const initialPage = 1;
  static const pageSize = 10;
  static const gridCrossAxisCount = 2;
  static const paginationThrottleMs = 500;
  static const scrollCheckStep = 30.0;

  static double get gridHorizontalPadding => 16.w;
  static double get gridVerticalPadding => 12.h;
  static double get gridCrossAxisSpacing => 12.w;
  static double get gridMainAxisSpacing => 12.h;
  static double get productCardBorderRadius => 12.r;
  static double get productCardPadding => 10.w;
  static double get productNameSpacing => 6.h;
  static double get productPriceSpacing => 4.h;
  static double get loadMoreTriggerOffset => 200.h;
  static double get discountBadgeBorderRadius => 6.r;
  static double get discountBadgeHorizontalPadding => 6.w;
  static double get discountBadgeVerticalPadding => 2.h;
  static double get ratingIconSize => 14.r;
  static double get ratingSpacing => 4.w;
  static double get loadMoreIndicatorPadding => 16.h;
  static double get loadMoreIndicatorSize => 24.r;
  static const productCardAspectRatio = 0.62;
  static const discountBadgeAlpha = 0.12;
  static const productImagePlaceholderIconAlpha = 0.35;
  static const ratingAlpha = 0.65;
}

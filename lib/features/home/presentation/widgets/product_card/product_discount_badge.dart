import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class ProductDiscountBadge extends StatelessWidget {
  const ProductDiscountBadge({super.key, required this.discountPercentage});

  final int discountPercentage;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: HomeDimension.discountBadgeAlpha),
        borderRadius: BorderRadius.circular(
          HomeDimension.discountBadgeBorderRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: HomeDimension.discountBadgeHorizontalPadding,
          vertical: HomeDimension.discountBadgeVerticalPadding,
        ),
        child: Text(
          '$discountPercentage% ${AppStrings.off}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

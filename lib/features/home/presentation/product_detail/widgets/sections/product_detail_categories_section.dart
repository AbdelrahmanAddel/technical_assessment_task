import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class ProductDetailCategoriesSection extends StatelessWidget {
  const ProductDetailCategoriesSection({super.key, required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    if (product.categories.isEmpty) return const SizedBox.shrink();

    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.categories,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: product.categories
              .map(
                (category) => Chip(
                  label: Text(category),
                  backgroundColor: colors.primary.withValues(
                    alpha: HomeDimension.discountBadgeAlpha,
                  ),
                  labelStyle: TextStyle(color: colors.primary),
                  side: BorderSide.none,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

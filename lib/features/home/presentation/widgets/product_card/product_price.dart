import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${product.finalPrice.toStringAsFixed(0)} ${AppStrings.currencySymbol}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (product.hasDiscount)
          Text(
            '${product.price.toStringAsFixed(0)} ${AppStrings.currencySymbol}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.text.withValues(alpha: HomeDimension.ratingAlpha),
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}

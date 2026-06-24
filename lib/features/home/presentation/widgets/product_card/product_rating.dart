import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          size: HomeDimension.ratingIconSize,
          color: colors.primary,
        ),
        horizontalSpace(HomeDimension.ratingSpacing),
        Text(
          '${product.rating.toStringAsFixed(1)} (${product.reviewsCount})',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.text.withValues(alpha: HomeDimension.ratingAlpha),
          ),
        ),
      ],
    );
  }
}

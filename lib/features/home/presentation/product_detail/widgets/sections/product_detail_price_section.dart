import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_rating.dart';

class ProductDetailPriceSection extends StatelessWidget {
  const ProductDetailPriceSection({super.key, required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${product.finalPrice.toStringAsFixed(0)} ${AppStrings.currencySymbol}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (product.hasDiscount) ...[
              horizontalSpace(8),
              Text(
                '${product.price.toStringAsFixed(0)} ${AppStrings.currencySymbol}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.text.withValues(alpha: HomeDimension.ratingAlpha),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
        if (product.reviewsCount > 0) ...[
          verticalSpace(HomeDimension.productNameSpacing),
          ProductRating(
            product: Product(
              id: product.id,
              name: product.name,
              description: product.description,
              coverPictureUrl: product.coverPictureUrl,
              price: product.price,
              rating: product.rating,
              reviewsCount: product.reviewsCount,
              discountPercentage: product.discountPercentage,
            ),
          ),
        ],
      ],
    );
  }
}

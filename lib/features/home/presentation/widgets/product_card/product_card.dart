import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_discount_badge.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_image.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_price.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_rating.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(
          HomeDimension.productCardBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ProductImage(coverPictureUrl: product.coverPictureUrl),
          ),
          Padding(
            padding: EdgeInsets.all(HomeDimension.productCardPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: colors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(HomeDimension.productNameSpacing),
                if (product.hasDiscount)
                  ProductDiscountBadge(
                    discountPercentage: product.discountPercentage,
                  ),
                if (product.hasDiscount)
                  verticalSpace(HomeDimension.productPriceSpacing),
                ProductPrice(product: product),
                if (product.reviewsCount > 0) ...[
                  verticalSpace(HomeDimension.productPriceSpacing),
                  ProductRating(product: product),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

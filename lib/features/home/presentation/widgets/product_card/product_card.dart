import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/core/router/routes_strings.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_discount_badge.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_image.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_price.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_rating.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await context.push(RoutesStrings.productDetail(product.id), extra: product);
          if (context.mounted) {
            context.read<ProductsCubit>().refreshProducts();
          }
        },
        borderRadius: BorderRadius.circular(
          HomeDimension.productCardBorderRadius,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(
              HomeDimension.productCardBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.text.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ProductImage(
                  productId: product.id,
                  coverPictureUrl: product.coverPictureUrl,
                ),
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
                    if (product.description.isNotEmpty) ...[
                      verticalSpace(HomeDimension.productNameSpacing),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.text.withValues(
                            alpha: HomeDimension.productDescriptionAlpha,
                          ),
                          height: 1.3,
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }
}

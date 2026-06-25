import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/widgets/product_card/product_discount_badge.dart';

class ProductDetailHeaderSection extends StatelessWidget {
  const ProductDetailHeaderSection({super.key, required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.hasDiscount)
          ProductDiscountBadge(discountPercentage: product.discountPercentage),
        if (product.hasDiscount) verticalSpace(HomeDimension.productNameSpacing),
        Text(
          product.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (product.nameArabic.isNotEmpty) ...[
          verticalSpace(4),
          Text(
            product.nameArabic,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colors.text.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
}

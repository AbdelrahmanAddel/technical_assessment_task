import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';

class ProductDetailDescriptionSection extends StatelessWidget {
  const ProductDetailDescriptionSection({super.key, required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.description,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpace(8),
        Text(
          product.description,
          style:textTheme.bodyMedium?.copyWith(
            color: colors.text.withValues(alpha: 0.8),
            height: 1.5,
          ),
        ),
        if (product.descriptionArabic.isNotEmpty) ...[
          verticalSpace(HomeDimension.detailFieldSpacing),
          Text(
            product.descriptionArabic,
            textDirection: TextDirection.rtl,
            style: textTheme.bodyMedium?.copyWith(
              color: colors.text.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

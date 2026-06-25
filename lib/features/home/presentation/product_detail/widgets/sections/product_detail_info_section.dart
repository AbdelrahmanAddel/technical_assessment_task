import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/product_detail_info_row.dart';

class ProductDetailInfoSection extends StatelessWidget {
  const ProductDetailInfoSection({super.key, required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductDetailInfoRow(
          icon: Icons.inventory_2_outlined,
          label: AppStrings.stock,
          value: '${product.stock} ${AppStrings.inStock}',
        ),
        verticalSpace(HomeDimension.detailFieldSpacing),
        ProductDetailInfoRow(
          icon: Icons.palette_outlined,
          label: AppStrings.color,
          value: product.color,
        ),
        verticalSpace(HomeDimension.detailFieldSpacing),
        ProductDetailInfoRow(
          icon: Icons.scale_outlined,
          label: AppStrings.weight,
          value: '${product.weight.toStringAsFixed(1)} kg',
        ),
        if (product.productCode.isNotEmpty) ...[
          verticalSpace(HomeDimension.detailFieldSpacing),
          ProductDetailInfoRow(
            icon: Icons.tag_outlined,
            label: AppStrings.productCode,
            value: product.productCode,
          ),
        ],
      ],
    );
  }
}

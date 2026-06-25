import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/product_detail_app_bar.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/sections/product_detail_actions_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/sections/product_detail_categories_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/sections/product_detail_description_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/sections/product_detail_header_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/sections/product_detail_info_section.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/sections/product_detail_price_section.dart';

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    super.key,
    required this.product,
    required this.isDeleting,
    required this.isRefreshing,
  });

  final ProductDetail product;
  final bool isDeleting;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          if (isRefreshing)
            const SliverToBoxAdapter(child: LinearProgressIndicator()),
          ProductDetailAppBar.sliver(
            context: context,
            product: product,
            isDeleting: isDeleting,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(HomeDimension.detailHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailHeaderSection(product: product),
                  verticalSpace(HomeDimension.detailSectionSpacing),
                  ProductDetailPriceSection(product: product),
                  verticalSpace(HomeDimension.detailSectionSpacing),
                  ProductDetailInfoSection(product: product),
                  if (product.categories.isNotEmpty) ...[
                    verticalSpace(HomeDimension.detailSectionSpacing),
                    ProductDetailCategoriesSection(product: product),
                  ],
                  verticalSpace(HomeDimension.detailSectionSpacing),
                  ProductDetailDescriptionSection(product: product),
                  verticalSpace(HomeDimension.detailBottomSpacing),
                  ProductDetailActionsSection(
                    product: product,
                    isDeleting: isDeleting,
                  ),
                  verticalSpace(HomeDimension.detailBottomSpacing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

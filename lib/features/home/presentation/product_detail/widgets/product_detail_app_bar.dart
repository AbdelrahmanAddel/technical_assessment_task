import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/delete_product_dialog.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/product_detail_image.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

abstract final class ProductDetailAppBar {
  static Future<void> _confirmDelete(
    BuildContext context,
    ProductDetail product,
  ) async {
    final shouldDelete = await DeleteProductDialog.show(context);
    if (shouldDelete == true && context.mounted) {
      context.read<ProductDetailCubit>().deleteProduct(productId: product.id);
    }
  }

  static SliverAppBar sliver({
    required BuildContext context,
    required ProductDetail product,
    required bool isDeleting,
  }) {
    final colors = context.colors;

    return SliverAppBar(
      expandedHeight: HomeDimension.detailImageHeight,
      pinned: true,
      stretch: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => UpdateProductBottomSheet.show(
            context: context,
            product: product,
          ),
        ),
        IconButton(
          icon: isDeleting
              ? SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.error,
                  ),
                )
              : Icon(Icons.delete_outline, color: colors.error),
          onPressed: isDeleting ? null : () => _confirmDelete(context, product),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: ProductDetailImage(
          productId: product.id,
          coverPictureUrl: product.coverPictureUrl,
        ),
      ),
    );
  }
}

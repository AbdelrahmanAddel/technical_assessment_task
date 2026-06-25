import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/delete_product_dialog.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_bottom_sheet.dart';

class ProductDetailActionsSection extends StatelessWidget {
  const ProductDetailActionsSection({
    super.key,
    required this.product,
    required this.isDeleting,
  });

  final ProductDetail product;
  final bool isDeleting;

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await DeleteProductDialog.show(context);
    if (shouldDelete == true && context.mounted) {
      context.read<ProductDetailCubit>().deleteProduct(productId: product.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      children: [
        AppButton(
          text: AppStrings.editProduct,
          icon: const Icon(Icons.edit_outlined, size: 18),
          onPressed: () => UpdateProductBottomSheet.show(
            context: context,
            product: product,
          ),
        ),
        verticalSpace(HomeDimension.detailFieldSpacing),
        AppButton(
          text: AppStrings.deleteProduct,
          backgroundColor: colors.error,
          icon: const Icon(Icons.delete_outline, size: 18),
          isLoading: isDeleting,
          onPressed: isDeleting ? null : () => _confirmDelete(context),
        ),
      ],
    );
  }
}

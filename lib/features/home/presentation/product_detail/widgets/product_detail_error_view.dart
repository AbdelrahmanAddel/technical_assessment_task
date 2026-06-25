import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';

class ProductDetailErrorView extends StatelessWidget {
  const ProductDetailErrorView({
    super.key,
    required this.message,
    required this.productId,
  });

  final String message;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(HomeDimension.detailHorizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: colors.error),
            verticalSpace(12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.text,
              ),
            ),
            verticalSpace(16),
            AppButton(
              text: AppStrings.retry,
              width: 160,
              onPressed: () => context.read<ProductDetailCubit>().loadProduct(
                productId: productId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

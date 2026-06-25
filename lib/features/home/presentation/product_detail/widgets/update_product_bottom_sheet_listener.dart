import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/update_product_params.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_state.dart';

class UpdateProductBottomSheetListener extends StatelessWidget {
  const UpdateProductBottomSheetListener({
    super.key,
    required this.lastSubmittedParams,
    required this.child,
  });

  final ValueNotifier<UpdateProductParams?> lastSubmittedParams;
  final Widget child;

  bool _updateSucceeded(ProductDetail product, UpdateProductParams params) {
    return product.name == params.name &&
        product.description == params.description &&
        product.price == params.price &&
        product.stock == params.stock &&
        product.color == params.color &&
        product.discountPercentage == params.discountPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailCubit, ProductDetailState>(
      listenWhen: (previous, current) =>
          previous is ProductDetailSuccess &&
          current is ProductDetailSuccess &&
          previous.isUpdating &&
          !current.isUpdating,
      listener: (context, state) {
        final params = lastSubmittedParams.value;
        if (params == null || state is! ProductDetailSuccess) return;

        if (_updateSucceeded(state.product, params)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.productUpdated)),
          );
          Navigator.of(context).pop();
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.failedToUpdateProduct)),
        );
        lastSubmittedParams.value = null;
      },
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/common/widget/app_button.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/extension/color_extension.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product_detail.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/update_product_params.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_state.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_bottom_sheet_listener.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_form.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_form_controllers.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_sheet_header.dart';

class UpdateProductBottomSheet extends StatefulWidget {
  const UpdateProductBottomSheet({super.key, required this.product});

  final ProductDetail product;

  static Future<void> show({
    required BuildContext context,
    required ProductDetail product,
  }) {
    final productDetailCubit = context.read<ProductDetailCubit>();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: productDetailCubit,
        child: UpdateProductBottomSheet(product: product),
      ),
    );
  }

  @override
  State<UpdateProductBottomSheet> createState() =>
      _UpdateProductBottomSheetState();
}

class _UpdateProductBottomSheetState extends State<UpdateProductBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _lastSubmittedParams = ValueNotifier<UpdateProductParams?>(null);
  late final UpdateProductFormControllers _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = UpdateProductFormControllers.fromProduct(widget.product);
  }

  @override
  void dispose() {
    _lastSubmittedParams.dispose();
    _controllers.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final params = _controllers.toParams();
    _lastSubmittedParams.value = params;

    context.read<ProductDetailCubit>().updateProduct(
      productId: widget.product.id,
      params: params,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return UpdateProductBottomSheetListener(
      lastSubmittedParams: _lastSubmittedParams,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(HomeDimension.detailSheetRadius),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              HomeDimension.detailHorizontalPadding,
              HomeDimension.detailSheetTopPadding,
              HomeDimension.detailHorizontalPadding,
              HomeDimension.detailSheetBottomPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UpdateProductSheetHeader(title: AppStrings.editProduct),
                UpdateProductForm(
                  formKey: _formKey,
                  controllers: _controllers,
                ),
                SizedBox(height: HomeDimension.detailSectionSpacing),
                BlocBuilder<ProductDetailCubit, ProductDetailState>(
                  builder: (context, state) {
                    final isUpdating =
                        state is ProductDetailSuccess && state.isUpdating;

                    return AppButton(
                      text: AppStrings.updateProduct,
                      isLoading: isUpdating,
                      onPressed: _submit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

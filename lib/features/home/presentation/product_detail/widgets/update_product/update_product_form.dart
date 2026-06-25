import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_techincal_test/core/common/widget/custom_text_form_field.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/helper/app_validation.dart';
import 'package:flutter_techincal_test/core/helper/spacer_helper.dart';
import 'package:flutter_techincal_test/features/home/presentation/home_dimen.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/update_product_form_controllers.dart';

class UpdateProductForm extends StatelessWidget {
  const UpdateProductForm({
    super.key,
    required this.formKey,
    required this.controllers,
  });

  final GlobalKey<FormState> formKey;
  final UpdateProductFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: controllers.name,
            labelText: AppStrings.name,
            hintText: AppStrings.enterProductName,
            textInputAction: TextInputAction.next,
            validator: (value) =>
                AppValidation.validate(ValidationType.name, value),
          ),
          verticalSpace(HomeDimension.detailFieldSpacing),
          CustomTextFormField(
            controller: controllers.description,
            labelText: AppStrings.description,
            hintText: AppStrings.enterDescription,
            maxLines: 3,
            textInputAction: TextInputAction.next,
          ),
          verticalSpace(HomeDimension.detailFieldSpacing),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: controllers.price,
                  labelText: AppStrings.enterPrice,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) =>
                      AppValidation.validate(ValidationType.price, value),
                ),
              ),
              horizontalSpace(HomeDimension.detailFieldSpacing),
              Expanded(
                child: CustomTextFormField(
                  controller: controllers.stock,
                  labelText: AppStrings.stock,
                  hintText: AppStrings.enterStock,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      AppValidation.validate(ValidationType.stock, value),
                ),
              ),
            ],
          ),
          verticalSpace(HomeDimension.detailFieldSpacing),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: controllers.color,
                  labelText: AppStrings.color,
                  hintText: AppStrings.enterColor,
                  textInputAction: TextInputAction.next,
                ),
              ),
              horizontalSpace(HomeDimension.detailFieldSpacing),
              Expanded(
                child: CustomTextFormField(
                  controller: controllers.discount,
                  labelText: AppStrings.off,
                  hintText: AppStrings.enterDiscount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

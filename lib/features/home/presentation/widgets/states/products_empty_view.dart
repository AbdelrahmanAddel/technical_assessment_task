import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/common/widget/app_placeholder_card.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';

class ProductsEmptyView extends StatelessWidget {
  const ProductsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPlaceholderCard(message: AppStrings.noProductsFound);
  }
}

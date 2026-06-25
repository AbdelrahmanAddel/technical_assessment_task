import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_state.dart';
import 'package:go_router/go_router.dart';

class ProductDetailListener extends StatelessWidget {
  const ProductDetailListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailCubit, ProductDetailState>(
      listenWhen: (_, current) => current is ProductDetailDeleted,
      listener: (context, state) {
        if (state is ProductDetailDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.productDeleted)),
          );
          context.pop(true);
        }
      },
      child: child,
    );
  }
}

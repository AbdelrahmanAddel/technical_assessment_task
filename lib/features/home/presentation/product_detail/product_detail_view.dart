import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_state.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/product_detail_content.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/product_detail_error_view.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return switch (state) {
          ProductDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          ProductDetailFailure(:final message) => ProductDetailErrorView(
            message: message,
            productId: productId,
          ),
          ProductDetailSuccess(
            :final product,
            :final isDeleting,
            :final isRefreshing,
          ) =>
            ProductDetailContent(
              product: product,
              isDeleting: isDeleting,
              isRefreshing: isRefreshing,
            ),
          ProductDetailInitial() || ProductDetailDeleted() =>
            const SizedBox.shrink(),
        };
      },
    );
  }
}

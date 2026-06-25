import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_techincal_test/core/di/dependency_injection.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/domain/usecases/delete_product_use_case.dart';
import 'package:flutter_techincal_test/features/home/domain/usecases/get_product_use_case.dart';
import 'package:flutter_techincal_test/features/home/domain/usecases/update_product_use_case.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/cubit/product_detail_cubit.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/product_detail_view.dart';
import 'package:flutter_techincal_test/features/home/presentation/product_detail/widgets/product_detail_listener.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.previewProduct,
  });

  final String productId;
  final Product? previewProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailCubit(
        getProductUseCase: getIt<GetProductUseCase>(),
        updateProductUseCase: getIt<UpdateProductUseCase>(),
        deleteProductUseCase: getIt<DeleteProductUseCase>(),
        previewProduct: previewProduct,
      )..loadProduct(productId: productId),
      child: ProductDetailListener(
        child: ProductDetailView(productId: productId),
      ),
    );
  }
}

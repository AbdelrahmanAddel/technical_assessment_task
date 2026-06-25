import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/entities/product_detail.dart';
import '../../../domain/entities/update_product_params.dart';
import '../../../domain/usecases/delete_product_use_case.dart';
import '../../../domain/usecases/get_product_use_case.dart';
import '../../../domain/usecases/update_product_use_case.dart';
import 'product_detail_state.dart';

final class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    required this.getProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    Product? previewProduct,
  }) : super(
         previewProduct != null
             ? ProductDetailSuccess(
                 product: ProductDetail.fromProduct(previewProduct),
                 isRefreshing: true,
               )
             : const ProductDetailInitial(),
       );

  final GetProductUseCase getProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  Future<void> loadProduct({required String productId}) async {
    final previousState = state;

    if (previousState is ProductDetailSuccess) {
      emit(previousState.copyWith(isRefreshing: true));
    } else {
      emit(const ProductDetailLoading());
    }

    final result = await getProductUseCase(id: productId);

    result.fold(
      (failure) {
        if (previousState is ProductDetailSuccess) {
          emit(previousState.copyWith(isRefreshing: false));
          return;
        }
        emit(ProductDetailFailure(failure.errMessage));
      },
      (product) => emit(ProductDetailSuccess(product: product)),
    );
  }

  Future<void> updateProduct({
    required String productId,
    required UpdateProductParams params,
  }) async {
    final currentState = state;
    if (currentState is! ProductDetailSuccess) return;

    emit(currentState.copyWith(isUpdating: true));

    final result = await updateProductUseCase(id: productId, params: params);

    result.fold(
      (failure) => emit(currentState.copyWith(isUpdating: false)),
      (product) => emit(ProductDetailSuccess(product: product)),
    );
  }

  Future<void> deleteProduct({required String productId}) async {
    final currentState = state;
    if (currentState is! ProductDetailSuccess) return;

    emit(currentState.copyWith(isDeleting: true));

    final result = await deleteProductUseCase(id: productId);

    result.fold(
      (failure) => emit(currentState.copyWith(isDeleting: false)),
      (_) => emit(const ProductDetailDeleted()),
    );
  }
}

import '../../../domain/entities/product_detail.dart';

sealed class ProductDetailState {
  const ProductDetailState();
}

final class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();
}

final class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

final class ProductDetailSuccess extends ProductDetailState {
  const ProductDetailSuccess({
    required this.product,
    this.isUpdating = false,
    this.isDeleting = false,
    this.isRefreshing = false,
  });

  final ProductDetail product;
  final bool isUpdating;
  final bool isDeleting;
  final bool isRefreshing;

  ProductDetailSuccess copyWith({
    ProductDetail? product,
    bool? isUpdating,
    bool? isDeleting,
    bool? isRefreshing,
  }) {
    return ProductDetailSuccess(
      product: product ?? this.product,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

final class ProductDetailFailure extends ProductDetailState {
  const ProductDetailFailure(this.message);

  final String message;
}

final class ProductDetailDeleted extends ProductDetailState {
  const ProductDetailDeleted();
}

import '../../domain/entities/product.dart';

sealed class ProductsState {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsSuccess extends ProductsState {
  const ProductsSuccess({
    required this.products,
    required this.hasNextPage,
    required this.currentPage,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  final List<Product> products;
  final bool hasNextPage;
  final int currentPage;
  final bool isLoadingMore;
  final bool isRefreshing;

  ProductsSuccess copyWith({
    List<Product>? products,
    bool? hasNextPage,
    int? currentPage,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

final class ProductsFailure extends ProductsState {
  const ProductsFailure(this.message);

  final String message;
}

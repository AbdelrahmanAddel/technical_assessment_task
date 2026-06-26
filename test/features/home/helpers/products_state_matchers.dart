import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/features/home/domain/entities/product.dart';
import 'package:flutter_techincal_test/features/home/presentation/cubit/products_state.dart';

Matcher isProductsSuccess({
  required List<Product> products,
  required bool hasNextPage,
  required int currentPage,
  bool isLoadingMore = false,
  bool isRefreshing = false,
}) {
  return isA<ProductsSuccess>()
      .having(
        (state) => state.products.map((product) => product.id).toList(),
        'productIds',
        products.map((product) => product.id).toList(),
      )
      .having((state) => state.hasNextPage, 'hasNextPage', hasNextPage)
      .having((state) => state.currentPage, 'currentPage', currentPage)
      .having((state) => state.isLoadingMore, 'isLoadingMore', isLoadingMore)
      .having((state) => state.isRefreshing, 'isRefreshing', isRefreshing);
}

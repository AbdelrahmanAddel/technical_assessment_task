import '../models/products_response.dart';

abstract interface class ProductsRemoteDataSource {
  Future<ProductsResponse> getProducts({
    required int page,
    required int pageSize,
  });
}

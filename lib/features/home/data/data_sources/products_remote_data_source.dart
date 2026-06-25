import '../models/product_detail_model.dart';
import '../models/products_response.dart';
import '../models/update_product_request.dart';

abstract interface class ProductsRemoteDataSource {
  Future<ProductsResponse> getProducts({
    required int page,
    required int pageSize,
  });

  Future<ProductDetailModel> getProductById({required String id});

  Future<ProductDetailModel> updateProduct({
    required String id,
    required UpdateProductRequest request,
  });

  Future<void> deleteProduct({required String id});
}

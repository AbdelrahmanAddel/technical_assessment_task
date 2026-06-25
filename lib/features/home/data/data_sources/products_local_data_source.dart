import '../models/product_detail_model.dart';
import '../models/products_response.dart';

abstract interface class ProductsLocalDataSource {
  Future<void> cacheProducts({
    required int page,
    required ProductsResponse response,
  });

  Future<ProductsResponse?> getCachedProducts({required int page});

  Future<void> cacheProductDetail(ProductDetailModel product);

  Future<ProductDetailModel?> getCachedProductDetail({required String id});

  Future<void> removeProductDetail({required String id});

  Future<void> removeProductFromCaches({required String id});

  Future<void> upsertProductInCaches(ProductDetailModel product);
}

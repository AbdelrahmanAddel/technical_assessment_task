import '../../../../core/api/result.dart';
import '../entities/product_detail.dart';
import '../entities/products.dart';
import '../entities/update_product_params.dart';

abstract interface class ProductsRepository {
  Future<Result<Products>> getProducts({
    required int page,
    required int pageSize,
  });

  Future<Result<ProductDetail>> getProductById({required String id});

  Future<Result<ProductDetail>> updateProduct({
    required String id,
    required UpdateProductParams params,
  });

  Future<Result<void>> deleteProduct({required String id});
}

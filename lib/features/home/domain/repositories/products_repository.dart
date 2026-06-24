import '../../../../core/api/result.dart';
import '../entities/products.dart';

abstract interface class ProductsRepository {
  Future<Result<Products>> getProducts({
    required int page,
    required int pageSize,
  });
}

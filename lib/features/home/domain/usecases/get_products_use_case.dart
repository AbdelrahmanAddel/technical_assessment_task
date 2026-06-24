import '../../../../core/api/result.dart';
import '../entities/products.dart';
import '../repositories/products_repository.dart';

final class GetProductsUseCase {
  const GetProductsUseCase({required this.productsRepository});

  final ProductsRepository productsRepository;

  Future<Result<Products>> call({
    required int page,
    required int pageSize,
  }) {
    return productsRepository.getProducts(page: page, pageSize: pageSize);
  }
}

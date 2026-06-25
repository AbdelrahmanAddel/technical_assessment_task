import '../../../../core/api/result.dart';
import '../entities/product_detail.dart';
import '../repositories/products_repository.dart';

final class GetProductUseCase {
  const GetProductUseCase({required this.productsRepository});

  final ProductsRepository productsRepository;

  Future<Result<ProductDetail>> call({required String id}) {
    return productsRepository.getProductById(id: id);
  }
}

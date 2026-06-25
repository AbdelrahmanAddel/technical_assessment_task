import '../../../../core/api/result.dart';
import '../entities/product_detail.dart';
import '../entities/update_product_params.dart';
import '../repositories/products_repository.dart';

final class UpdateProductUseCase {
  const UpdateProductUseCase({required this.productsRepository});

  final ProductsRepository productsRepository;

  Future<Result<ProductDetail>> call({
    required String id,
    required UpdateProductParams params,
  }) {
    return productsRepository.updateProduct(id: id, params: params);
  }
}

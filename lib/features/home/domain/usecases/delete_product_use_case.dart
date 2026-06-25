import '../../../../core/api/result.dart';
import '../repositories/products_repository.dart';

final class DeleteProductUseCase {
  const DeleteProductUseCase({required this.productsRepository});

  final ProductsRepository productsRepository;

  Future<Result<void>> call({required String id}) {
    return productsRepository.deleteProduct(id: id);
  }
}

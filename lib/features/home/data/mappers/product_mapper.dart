import '../../domain/entities/product.dart';
import '../../domain/entities/products.dart';
import '../models/product_model.dart';
import '../models/products_response.dart';

abstract final class ProductMapper {
  static Product toProductEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      description: model.description,
      coverPictureUrl: model.coverPictureUrl,
      price: model.price,
      rating: model.rating,
      reviewsCount: model.reviewsCount,
      discountPercentage: model.discountPercentage,
    );
  }

  static Products toProductsEntity(ProductsResponse response) {
    return Products(
      items: response.items.map(toProductEntity).toList(),
      page: response.page,
      hasNextPage: response.hasNextPage,
    );
  }
}

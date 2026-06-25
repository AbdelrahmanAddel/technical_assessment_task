import '../../domain/entities/product_detail.dart';
import '../models/product_detail_model.dart';

abstract final class ProductDetailMapper {
  static ProductDetail toEntity(ProductDetailModel model) {
    return ProductDetail(
      id: model.id,
      productCode: model.productCode,
      name: model.name,
      description: model.description,
      nameArabic: model.nameArabic,
      descriptionArabic: model.descriptionArabic,
      coverPictureUrl: model.coverPictureUrl,
      productPictures: model.productPictures,
      categories: model.categories,
      price: model.price,
      stock: model.stock,
      weight: model.weight,
      color: model.color,
      discountPercentage: model.discountPercentage,
      rating: model.rating,
      reviewsCount: model.reviewsCount,
      sellerId: model.sellerId,
    );
  }
}

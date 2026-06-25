import 'product.dart';

final class ProductDetail {
  const ProductDetail({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.nameArabic,
    required this.descriptionArabic,
    required this.coverPictureUrl,
    required this.productPictures,
    required this.categories,
    required this.price,
    required this.stock,
    required this.weight,
    required this.color,
    required this.discountPercentage,
    required this.rating,
    required this.reviewsCount,
    required this.sellerId,
  });

  factory ProductDetail.fromProduct(Product product) {
    return ProductDetail(
      id: product.id,
      productCode: '',
      name: product.name,
      description: product.description,
      nameArabic: '',
      descriptionArabic: '',
      coverPictureUrl: product.coverPictureUrl,
      productPictures: product.coverPictureUrl.isNotEmpty
          ? [product.coverPictureUrl]
          : const [],
      categories: const [],
      price: product.price,
      stock: 0,
      weight: 0,
      color: '',
      discountPercentage: product.discountPercentage,
      rating: product.rating,
      reviewsCount: product.reviewsCount,
      sellerId: '',
    );
  }

  final String id;
  final String productCode;
  final String name;
  final String description;
  final String nameArabic;
  final String descriptionArabic;
  final String coverPictureUrl;
  final List<String> productPictures;
  final List<String> categories;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final int discountPercentage;
  final double rating;
  final int reviewsCount;
  final String sellerId;

  double get finalPrice {
    if (discountPercentage <= 0) return price;
    return price * (1 - discountPercentage / 100);
  }

  bool get hasDiscount => discountPercentage > 0;
}

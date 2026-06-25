import '../../../../core/constant/api_strings.dart';

final class ProductDetailModel {
  const ProductDetailModel({
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

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json[ApiKeys.id] as String,
      productCode: json[ApiKeys.productCode] as String? ?? '',
      name: json[ApiKeys.name] as String,
      description: json[ApiKeys.description] as String? ?? '',
      nameArabic: json[ApiKeys.nameArabic] as String? ?? '',
      descriptionArabic: json[ApiKeys.descriptionArabic] as String? ?? '',
      coverPictureUrl: json[ApiKeys.coverPictureUrl] as String? ?? '',
      productPictures: _toStringList(json[ApiKeys.productPictures]),
      categories: _toStringList(json[ApiKeys.categories]),
      price: _toDouble(json[ApiKeys.price]),
      stock: _toInt(json[ApiKeys.stock]),
      weight: _toDouble(json[ApiKeys.weight]),
      color: json[ApiKeys.color] as String? ?? '',
      discountPercentage: _toInt(json[ApiKeys.discountPercentage]),
      rating: _toDouble(json[ApiKeys.rating]),
      reviewsCount: _toInt(json[ApiKeys.reviewsCount]),
      sellerId: json[ApiKeys.sellerId] as String? ?? '',
    );
  }

  static List<String> _toStringList(dynamic value) {
    if (value is! List) return const [];
    return value.whereType<String>().toList();
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

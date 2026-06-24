import '../../../../core/constant/api_strings.dart';

final class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.coverPictureUrl,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
  });

  final String id;
  final String name;
  final String coverPictureUrl;
  final double price;
  final double rating;
  final int reviewsCount;
  final int discountPercentage;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ApiKeys.id] as String,
      name: json[ApiKeys.name] as String,
      coverPictureUrl: json[ApiKeys.coverPictureUrl] as String? ?? '',
      price: _toDouble(json[ApiKeys.price]),
      rating: _toDouble(json[ApiKeys.rating]),
      reviewsCount: _toInt(json[ApiKeys.reviewsCount]),
      discountPercentage: _toInt(json[ApiKeys.discountPercentage]),
    );
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

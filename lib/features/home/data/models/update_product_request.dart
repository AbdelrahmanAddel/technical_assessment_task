import '../../../../core/constant/api_strings.dart';

final class UpdateProductRequest {
  const UpdateProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.color,
    required this.discountPercentage,
  });

  final String name;
  final String description;
  final double price;
  final int stock;
  final String color;
  final int discountPercentage;

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.description: description,
      ApiKeys.price: price,
      ApiKeys.stock: stock,
      ApiKeys.color: color,
      ApiKeys.discountPercentage: discountPercentage,
    };
  }
}

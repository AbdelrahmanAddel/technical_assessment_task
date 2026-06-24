import '../../../../core/constant/api_strings.dart';
import 'product_model.dart';

final class ProductsResponse {
  const ProductsResponse({
    required this.items,
    required this.page,
    required this.hasNextPage,
  });

  final List<ProductModel> items;
  final int page;
  final bool hasNextPage;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    final rawItems = json[ApiKeys.items];

    return ProductsResponse(
      items: rawItems is List
          ? rawItems
                .whereType<Map<String, dynamic>>()
                .map(ProductModel.fromJson)
                .toList()
          : const [],
      page: _toInt(json[ApiKeys.page], fallback: 1),
      hasNextPage: json[ApiKeys.hasNextPage] as bool? ?? false,
    );
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }
}

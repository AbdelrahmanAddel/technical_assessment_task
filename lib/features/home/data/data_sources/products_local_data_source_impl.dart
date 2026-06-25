import 'dart:convert';

import '../../../../core/cache/hive_boxes.dart';
import '../../../../core/constant/storage_keys.dart';
import '../../../../core/helper/json_helper.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/products_response.dart';
import 'products_local_data_source.dart';

final class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  const ProductsLocalDataSourceImpl();

  @override
  Future<void> cacheProducts({
    required int page,
    required ProductsResponse response,
  }) async {
    await HiveBoxes.products.put(
      StorageKeys.productsPageKey(page),
      jsonEncode(response.toJson()),
    );
  }

  @override
  Future<ProductsResponse?> getCachedProducts({required int page}) async {
    final cachedPage = _readProductsPage(StorageKeys.productsPageKey(page));
    if (cachedPage != null && cachedPage.items.isNotEmpty) {
      return cachedPage;
    }

    return _readFirstAvailableProductsPage();
  }

  @override
  Future<void> cacheProductDetail(ProductDetailModel product) async {
    await HiveBoxes.productDetails.put(
      product.id,
      jsonEncode(product.toJson()),
    );
  }

  @override
  Future<ProductDetailModel?> getCachedProductDetail({required String id}) async {
    final raw = HiveBoxes.productDetails.get(id);
    return _parseProductDetail(raw);
  }

  @override
  Future<void> removeProductDetail({required String id}) async {
    await HiveBoxes.productDetails.delete(id);
  }

  @override
  Future<void> removeProductFromCaches({required String id}) async {
    await removeProductDetail(id: id);

    for (final key in HiveBoxes.products.keys) {
      final response = _readProductsPage(key);
      if (response == null) continue;

      final updatedItems = response.items
          .where((product) => product.id != id)
          .toList();

      if (updatedItems.length == response.items.length) continue;

      await HiveBoxes.products.put(
        key,
        jsonEncode(
          ProductsResponse(
            items: updatedItems,
            page: response.page,
            hasNextPage: response.hasNextPage,
          ).toJson(),
        ),
      );
    }
  }

  @override
  Future<void> upsertProductInCaches(ProductDetailModel product) async {
    await cacheProductDetail(product);

    final listProduct = ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      coverPictureUrl: product.coverPictureUrl,
      price: product.price,
      rating: product.rating,
      reviewsCount: product.reviewsCount,
      discountPercentage: product.discountPercentage,
    );

    for (final key in HiveBoxes.products.keys) {
      final response = _readProductsPage(key);
      if (response == null) continue;

      final index = response.items.indexWhere((item) => item.id == product.id);
      if (index == -1) continue;

      final updatedItems = [...response.items];
      updatedItems[index] = listProduct;

      await HiveBoxes.products.put(
        key,
        jsonEncode(
          ProductsResponse(
            items: updatedItems,
            page: response.page,
            hasNextPage: response.hasNextPage,
          ).toJson(),
        ),
      );
    }
  }

  ProductsResponse? _readProductsPage(dynamic key) {
    final raw = HiveBoxes.products.get(key);
    return _parseProductsResponse(raw);
  }

  ProductsResponse? _readFirstAvailableProductsPage() {
    for (final key in HiveBoxes.products.keys) {
      final response = _readProductsPage(key);
      if (response != null && response.items.isNotEmpty) {
        return response;
      }
    }

    return null;
  }

  ProductsResponse? _parseProductsResponse(dynamic raw) {
    try {
      final map = _decodeToMap(raw);
      if (map == null) return null;

      return ProductsResponse.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  ProductDetailModel? _parseProductDetail(dynamic raw) {
    try {
      final map = _decodeToMap(raw);
      if (map == null) return null;

      return ProductDetailModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic>? _decodeToMap(dynamic raw) {
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      return JsonHelper.toStringKeyMap(decoded);
    }

    if (raw is Map) {
      return JsonHelper.toStringKeyMap(raw);
    }

    return null;
  }
}

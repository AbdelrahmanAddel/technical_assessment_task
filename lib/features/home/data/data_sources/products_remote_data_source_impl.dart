import '../../../../core/api/api_consumer.dart';
import '../../../../core/constant/api_strings.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/product_detail_model.dart';
import '../models/products_response.dart';
import '../models/update_product_request.dart';
import 'products_remote_data_source.dart';

final class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  const ProductsRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<ProductsResponse> getProducts({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await apiConsumer.get(
        path: ApiKeys.products,
        body: {
          ApiKeys.page: page,
          ApiKeys.pageSize: pageSize,
        },
      );

      if (response is! Map<String, dynamic>) {
        throw ServerException(message: AppStrings.failedToLoadProducts);
      }

      return ProductsResponse.fromJson(response);
    } on FormatException {
      throw ServerException(message: AppStrings.failedToLoadProducts);
    }
  }

  @override
  Future<ProductDetailModel> getProductById({required String id}) async {
    try {
      final response = await apiConsumer.get(path: ApiKeys.productById(id));

      if (response is! Map<String, dynamic>) {
        throw ServerException(message: AppStrings.failedToLoadProduct);
      }

      return ProductDetailModel.fromJson(response);
    } on FormatException {
      throw ServerException(message: AppStrings.failedToLoadProduct);
    }
  }

  @override
  Future<ProductDetailModel> updateProduct({
    required String id,
    required UpdateProductRequest request,
  }) async {
    try {
      final response = await apiConsumer.put(
        path: ApiKeys.productById(id),
        body: request.toJson(),
      );

      if (response is! Map<String, dynamic>) {
        throw ServerException(message: AppStrings.failedToUpdateProduct);
      }

      return ProductDetailModel.fromJson(response);
    } on FormatException {
      throw ServerException(message: AppStrings.failedToUpdateProduct);
    }
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    try {
      await apiConsumer.delete(path: ApiKeys.productById(id));
    } on FormatException {
      throw ServerException(message: AppStrings.failedToDeleteProduct);
    }
  }
}

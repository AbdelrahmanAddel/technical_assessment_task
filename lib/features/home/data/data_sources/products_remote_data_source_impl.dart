import '../../../../core/api/api_consumer.dart';
import '../../../../core/constant/api_strings.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/products_response.dart';
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
}

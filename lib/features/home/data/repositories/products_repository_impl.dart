import 'package:dio/dio.dart';

import '../../../../core/api/result.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/products.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_sources/products_remote_data_source.dart';
import '../mappers/product_mapper.dart';

final class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl({required this.remoteDataSource});

  final ProductsRemoteDataSource remoteDataSource;

  @override
  Future<Result<Products>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await remoteDataSource.getProducts(
        page: page,
        pageSize: pageSize,
      );

      return Success(ProductMapper.toProductsEntity(response));
    } on DioException catch (error) {
      return FailureResult(ServerFailure.fromDioException(dioException: error));
    } on ServerException catch (error) {
      return FailureResult(ServerFailure(errMessage: error.message));
    } catch (_) {
      return const FailureResult(
        ServerFailure(errMessage: 'Unexpected error, please try later.'),
      );
    }
  }
}

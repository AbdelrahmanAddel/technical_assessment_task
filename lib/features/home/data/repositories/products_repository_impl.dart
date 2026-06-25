import 'package:dio/dio.dart';

import '../../../../core/api/result.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_detail.dart';
import '../../domain/entities/products.dart';
import '../../domain/entities/update_product_params.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_sources/products_remote_data_source.dart';
import '../mappers/product_detail_mapper.dart';
import '../mappers/product_mapper.dart';
import '../models/update_product_request.dart';

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

  @override
  Future<Result<ProductDetail>> getProductById({required String id}) async {
    try {
      final response = await remoteDataSource.getProductById(id: id);
      return Success(ProductDetailMapper.toEntity(response));
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

  @override
  Future<Result<ProductDetail>> updateProduct({
    required String id,
    required UpdateProductParams params,
  }) async {
    try {
      final response = await remoteDataSource.updateProduct(
        id: id,
        request: UpdateProductRequest(
          name: params.name,
          description: params.description,
          price: params.price,
          stock: params.stock,
          color: params.color,
          discountPercentage: params.discountPercentage,
        ),
      );
      return Success(ProductDetailMapper.toEntity(response));
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

  @override
  Future<Result<void>> deleteProduct({required String id}) async {
    try {
      await remoteDataSource.deleteProduct(id: id);
      return const Success(null);
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

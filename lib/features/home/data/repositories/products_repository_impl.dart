import 'package:dio/dio.dart';

import '../../../../core/api/result.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product_detail.dart';
import '../../domain/entities/products.dart';
import '../../domain/entities/update_product_params.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_sources/products_local_data_source.dart';
import '../data_sources/products_remote_data_source.dart';
import '../mappers/product_detail_mapper.dart';
import '../mappers/product_mapper.dart';
import '../models/update_product_request.dart';

final class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Result<Products>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    if (!await networkInfo.isConnected) {
      final cached = await localDataSource.getCachedProducts(page: page);
      if (cached != null) {
        return Success(ProductMapper.toProductsEntity(cached));
      }
    }

    try {
      final response = await remoteDataSource.getProducts(
        page: page,
        pageSize: pageSize,
      );

      try {
        await localDataSource.cacheProducts(page: page, response: response);
      } catch (_) {}

      return Success(ProductMapper.toProductsEntity(response));
    } on DioException catch (error) {
      return _getProductsFromCacheOrFail(
        page: page,
        error: error,
      );
    } on ServerException catch (error) {
      return _getProductsFromCacheOrFailOnServerError(
        page: page,
        error: error,
      );
    } catch (_) {
      return _getProductsFromCacheOrFailOnUnknown(page: page);
    }
  }

  @override
  Future<Result<ProductDetail>> getProductById({required String id}) async {
    if (!await networkInfo.isConnected) {
      final cached = await localDataSource.getCachedProductDetail(id: id);
      if (cached != null) {
        return Success(ProductDetailMapper.toEntity(cached));
      }
    }

    try {
      final response = await remoteDataSource.getProductById(id: id);

      try {
        await localDataSource.cacheProductDetail(response);
      } catch (_) {}

      return Success(ProductDetailMapper.toEntity(response));
    } on DioException catch (error) {
      return _getProductDetailFromCacheOrFail(
        id: id,
        error: error,
      );
    } on ServerException catch (error) {
      return _getProductDetailFromCacheOrFailOnServerError(
        id: id,
        error: error,
      );
    } catch (_) {
      return _getProductDetailFromCacheOrFailOnUnknown(id: id);
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

      await localDataSource.upsertProductInCaches(response);

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
      await localDataSource.removeProductFromCaches(id: id);

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

  Future<Result<Products>> _getProductsFromCacheOrFail({
    required int page,
    required DioException error,
  }) async {
    final cached = await localDataSource.getCachedProducts(page: page);
    if (cached != null) {
      return Success(ProductMapper.toProductsEntity(cached));
    }

    return FailureResult(ServerFailure.fromDioException(dioException: error));
  }

  Future<Result<ProductDetail>> _getProductDetailFromCacheOrFail({
    required String id,
    required DioException error,
  }) async {
    final cached = await localDataSource.getCachedProductDetail(id: id);
    if (cached != null) {
      return Success(ProductDetailMapper.toEntity(cached));
    }

    return FailureResult(ServerFailure.fromDioException(dioException: error));
  }

  Future<Result<Products>> _getProductsFromCacheOrFailOnServerError({
    required int page,
    required ServerException error,
  }) async {
    if (!await networkInfo.isConnected) {
      final cached = await localDataSource.getCachedProducts(page: page);
      if (cached != null) {
        return Success(ProductMapper.toProductsEntity(cached));
      }
    }

    return FailureResult(ServerFailure(errMessage: error.message));
  }

  Future<Result<Products>> _getProductsFromCacheOrFailOnUnknown({
    required int page,
  }) async {
    final cached = await localDataSource.getCachedProducts(page: page);
    if (cached != null) {
      return Success(ProductMapper.toProductsEntity(cached));
    }

    return const FailureResult(
      ServerFailure(errMessage: 'Unexpected error, please try later.'),
    );
  }

  Future<Result<ProductDetail>> _getProductDetailFromCacheOrFailOnServerError({
    required String id,
    required ServerException error,
  }) async {
    if (!await networkInfo.isConnected) {
      final cached = await localDataSource.getCachedProductDetail(id: id);
      if (cached != null) {
        return Success(ProductDetailMapper.toEntity(cached));
      }
    }

    return FailureResult(ServerFailure(errMessage: error.message));
  }

  Future<Result<ProductDetail>> _getProductDetailFromCacheOrFailOnUnknown({
    required String id,
  }) async {
    final cached = await localDataSource.getCachedProductDetail(id: id);
    if (cached != null) {
      return Success(ProductDetailMapper.toEntity(cached));
    }

    return const FailureResult(
      ServerFailure(errMessage: 'Unexpected error, please try later.'),
    );
  }
}

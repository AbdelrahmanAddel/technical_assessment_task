import 'package:dio/dio.dart';

import '../../../../core/api/result.dart';
import '../../../../core/cache/hive_boxes.dart';
import '../../../../core/constant/storage_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../mappers/auth_mapper.dart';
import '../models/register_request.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage secureStorage;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await secureStorage.write(
        key: StorageKeys.accessToken,
        value: response.accessToken,
      );
      await secureStorage.write(
        key: StorageKeys.refreshToken,
        value: response.refreshToken,
      );

      return Success(AuthMapper.toEntity(response));
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
  Future<Result<void>> register({
    required RegisterRequestParameters request,
  }) async {
    try {
      await remoteDataSource.register(request: request);
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

  @override
  Future<bool> hasCachedToken() async {
    final token = await secureStorage.read(key: StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final response = await remoteDataSource.getCurrentUser();
      return Success(AuthMapper.toUserEntity(response));
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
  Future<Result<void>> logout() async {
    try {
      await remoteDataSource.logout();
      await _clearLocalSession();
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

  Future<void> _clearLocalSession() async {
    await secureStorage.delete(key: StorageKeys.accessToken);
    await secureStorage.delete(key: StorageKeys.refreshToken);
    await HiveBoxes.products.clear();
    await HiveBoxes.productDetails.clear();
  }

  @override
  Future<Result<void>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      await remoteDataSource.verifyEmail(email: email, otp: otp);
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

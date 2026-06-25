import 'package:dio/dio.dart';

import '../../../../core/api/result.dart';
import '../../../../core/cache/hive_boxes.dart';
import '../../../../core/constant/storage_keys.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/app_prefs.dart';
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
    required this.appPrefs,
    required this.networkInfo,
  });

  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage secureStorage;
  final AppPrefs appPrefs;
  final NetworkInfo networkInfo;

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
  User? getCachedUser() {
    final cached = appPrefs.cachedUser;
    if (cached == null) return null;

    return User(
      userId: cached.userId,
      email: cached.email,
      fullName: cached.fullName,
      profilePicture: cached.profilePicture,
    );
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    if (!await networkInfo.isConnected) {
      final cached = getCachedUser();
      if (cached != null) {
        return Success(cached);
      }
    }

    try {
      final response = await remoteDataSource.getCurrentUser();
      final user = AuthMapper.toUserEntity(response);
      await _cacheUser(user);
      return Success(user);
    } on DioException catch (error) {
      return _getCachedUserOrFail(error);
    } on ServerException catch (error) {
      return _getCachedUserOrFailOnServerError(error);
    } catch (_) {
      return _getCachedUserOrFailOnUnknown();
    }
  }

  Future<void> _cacheUser(User user) async {
    await appPrefs.saveUser(
      userId: user.userId,
      name: user.fullName,
      email: user.email,
      profilePicture: user.profilePicture,
    );
  }

  Future<Result<User>> _getCachedUserOrFail(DioException error) async {
    final cached = getCachedUser();
    if (cached != null) {
      return Success(cached);
    }

    return FailureResult(ServerFailure.fromDioException(dioException: error));
  }

  Future<Result<User>> _getCachedUserOrFailOnServerError(
    ServerException error,
  ) async {
    if (!await networkInfo.isConnected) {
      final cached = getCachedUser();
      if (cached != null) {
        return Success(cached);
      }
    }

    return FailureResult(ServerFailure(errMessage: error.message));
  }

  Future<Result<User>> _getCachedUserOrFailOnUnknown() async {
    final cached = getCachedUser();
    if (cached != null) {
      return Success(cached);
    }

    return const FailureResult(
      ServerFailure(errMessage: 'Unexpected error, please try later.'),
    );
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
    await appPrefs.clearUser();
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

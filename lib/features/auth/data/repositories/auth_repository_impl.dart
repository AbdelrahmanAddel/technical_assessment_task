import 'package:dio/dio.dart';

import '../../../../core/api/result.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../mappers/auth_mapper.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

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
}

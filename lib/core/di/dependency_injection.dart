import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_auth_use_case.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/register_use_case.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/register_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../constant/api_strings.dart';
import '../helper/secure_storage.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  _setupCore();
  _setupAuthFeature();
}

void _setupCore() {
  if (getIt.isRegistered<Dio>()) return;

  final dio = Dio(BaseOptions(baseUrl: ApiKeys.baseUrl));
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  getIt
    ..registerSingleton<Dio>(dio)
    ..registerLazySingleton<SecureStorage>(
      () => SecureStorage(storage: const FlutterSecureStorage()),
    )
    ..registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));
}

void _setupAuthFeature() {
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        secureStorage: getIt<SecureStorage>(),
      ),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: getIt<AuthRepository>()),
    )
    ..registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(authRepository: getIt<AuthRepository>()),
    )
    ..registerLazySingleton<CheckAuthUseCase>(
      () => CheckAuthUseCase(authRepository: getIt<AuthRepository>()),
    )
    ..registerFactory<LoginCubit>(
      () => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
    )
    ..registerFactory<RegisterCubit>(
      () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
    );
}

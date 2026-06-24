import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../constant/api_strings.dart';

final GetIt getIt = GetIt.instance;
void setupDependencyInjection() async {
  _setupCore();
  _setupAuthFeature();
}

void _setupCore() {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

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
    ..registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));
}

void _setupAuthFeature() {
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: getIt<AuthRepository>()),
    )
    ..registerFactory<LoginCubit>(
      () => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
    );
}

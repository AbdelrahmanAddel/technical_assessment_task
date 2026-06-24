import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../constant/api_strings.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  getIt
    ..registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: ApiKeys.baseUrl)),
    )
    ..registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()))
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

import 'package:connectivity_plus/connectivity_plus.dart';
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
import '../../features/auth/domain/usecases/verify_email_use_case.dart';
import '../../features/auth/presentation/cubit/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp_cubit.dart';
import '../../features/auth/presentation/cubit/register_cubit.dart';
import '../../features/home/data/data_sources/products_local_data_source.dart';
import '../../features/home/data/data_sources/products_local_data_source_impl.dart';
import '../../features/home/data/data_sources/products_remote_data_source.dart';
import '../../features/home/data/data_sources/products_remote_data_source_impl.dart';
import '../../features/home/data/repositories/products_repository_impl.dart';
import '../../features/home/domain/repositories/products_repository.dart';
import '../../features/home/domain/usecases/delete_product_use_case.dart';
import '../../features/home/domain/usecases/get_product_use_case.dart';
import '../../features/home/domain/usecases/get_products_use_case.dart';
import '../../features/home/domain/usecases/update_product_use_case.dart';
import '../../features/home/presentation/cubit/products_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../cache/hive_boxes.dart';
import '../constant/api_strings.dart';
import '../helper/secure_storage.dart';
import '../network/network_info.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  await HiveBoxes.init();
  _setupCore();
  _setupAuthFeature();
  _setupHomeFeature();
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
    ..registerLazySingleton<Connectivity>(() => Connectivity())
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: getIt<Connectivity>()),
    )
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
    ..registerLazySingleton<VerifyEmailUseCase>(
      () => VerifyEmailUseCase(authRepository: getIt<AuthRepository>()),
    )
    ..registerFactory<LoginCubit>(
      () => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
    )
    ..registerFactory<RegisterCubit>(
      () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
    )
    ..registerFactory<OtpCubit>(
      () => OtpCubit(verifyEmailUseCase: getIt<VerifyEmailUseCase>()),
    );
}

void _setupHomeFeature() {
  getIt
    ..registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    )
    ..registerLazySingleton<ProductsLocalDataSource>(
      () => const ProductsLocalDataSourceImpl(),
    )
    ..registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(
        remoteDataSource: getIt<ProductsRemoteDataSource>(),
        localDataSource: getIt<ProductsLocalDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(productsRepository: getIt<ProductsRepository>()),
    )
    ..registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(productsRepository: getIt<ProductsRepository>()),
    )
    ..registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(productsRepository: getIt<ProductsRepository>()),
    )
    ..registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(productsRepository: getIt<ProductsRepository>()),
    )
    ..registerFactory<ProductsCubit>(
      () => ProductsCubit(getProductsUseCase: getIt<GetProductsUseCase>()),
    );
}

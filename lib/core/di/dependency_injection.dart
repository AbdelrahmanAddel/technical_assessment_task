import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  getIt
    ..registerSingleton<Dio>(Dio())
    ..registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));
}

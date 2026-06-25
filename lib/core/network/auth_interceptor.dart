import 'package:dio/dio.dart';

import '../constant/storage_keys.dart';
import '../storage/secure_storage.dart';

final class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.instance.read(
      key: StorageKeys.accessToken,
    );

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

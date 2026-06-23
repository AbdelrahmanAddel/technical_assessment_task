import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get({
    required String path,
    Object? body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<dynamic> post({
    required String path,
    Object? body,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });

  Future<dynamic> put({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<dynamic> patch({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<dynamic> delete({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });
}

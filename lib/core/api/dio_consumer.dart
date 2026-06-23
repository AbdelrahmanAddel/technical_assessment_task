import 'package:dio/dio.dart';

import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  DioConsumer({required this.dio}) {
    dio.options
      ..receiveDataWhenStatusError = true
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..headers = const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  }

  final Dio dio;

  @override
  Future<dynamic> get({
    required String path,
    Object? body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get<dynamic>(
      path,
      data: body,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future<dynamic> post({
    required String path,
    Object? body,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.post<dynamic>(
      path,
      data: formData ?? body,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: Options(
        headers: headers,
        contentType: formData != null
            ? Headers.multipartFormDataContentType
            : null,
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> put({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.put<dynamic>(
      path,
      data: body,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future<dynamic> patch({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.patch<dynamic>(
      path,
      data: body,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  @override
  Future<dynamic> delete({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.delete<dynamic>(
      path,
      data: body,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

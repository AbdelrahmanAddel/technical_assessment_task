import 'dart:io';

import 'package:dio/dio.dart';

abstract final class NetworkFailureHelper {
  static bool isNetworkRelated(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError => true,
      DioExceptionType.unknown => exception.error is SocketException,
      _ => false,
    };
  }
}

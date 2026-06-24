import 'package:dio/dio.dart';

abstract class Failures {
  const Failures({required this.errMessage});

  final String errMessage;
}

class ServerFailure extends Failures {
  const ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioException({required DioException dioException}) {
    return switch (dioException.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const ServerFailure(
        errMessage: 'Connection timed out.',
      ),
      DioExceptionType.badCertificate => const ServerFailure(
        errMessage: 'Secure connection failed. Please try again later.',
      ),
      DioExceptionType.badResponse => ServerFailure.fromResponse(
        statusCode: dioException.response?.statusCode,
        response: dioException.response?.data,
      ),
      DioExceptionType.cancel => const ServerFailure(
        errMessage: 'Request was canceled.',
      ),
      DioExceptionType.connectionError => const ServerFailure(
        errMessage: 'No internet connection.',
      ),
      DioExceptionType.unknown => const ServerFailure(
        errMessage: 'Unexpected error, please try later.',
      ),
    };
  }

  factory ServerFailure.fromResponse({int? statusCode, dynamic response}) {
    final message = _extractMessage(response);

    return switch (statusCode) {
      400 ||
      401 ||
      403 ||
      404 ||
      409 ||
      422 ||
      500 => ServerFailure(errMessage: message),
      _ => const ServerFailure(
        errMessage: 'Oops there was an error, please try later.',
      ),
    };
  }

  static String _extractMessage(dynamic response) {
    if (response is Map<String, dynamic>) {
      final errors = response['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final errorMessages = <String>[];
        errors.forEach((key, value) {
          if (value is List) {
            for (final err in value) {
              if (err is String && err.trim().isNotEmpty) {
                errorMessages.add(err);
              }
            }
          } else if (value is String && value.trim().isNotEmpty) {
            errorMessages.add(value);
          }
        });
        if (errorMessages.isNotEmpty) {
          return errorMessages.join('\n');
        }
      }

      final directMessage =
          response['message'] ??
          response['Message'] ??
          response['error_description'] ??
          response['error'] ??
          response['title'];

      if (directMessage is String && directMessage.trim().isNotEmpty) {
        return directMessage;
      }
    }

    if (response is String && response.trim().isNotEmpty) {
      return response;
    }

    return 'Unexpected error, please try later.';
  }
}

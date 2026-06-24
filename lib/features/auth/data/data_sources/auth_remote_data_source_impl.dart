import '../../../../core/api/api_consumer.dart';
import '../../../../core/constant/api_strings.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import 'auth_remote_data_source.dart';

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await apiConsumer.post(
        path: ApiKeys.authLogin,
        body: request.toJson(),
      );

      if (response is! Map<String, dynamic>) {
        throw ServerException(message: AppStrings.invalidLoginResponse);
      }

      return LoginResponse.fromJson(response);
    } on FormatException {
      throw ServerException(message: AppStrings.invalidLoginResponse);
    }
  }

  @override
  Future<void> register({required RegisterRequestParameters request}) async {
    await apiConsumer.post(path: ApiKeys.authRegister, body: request.toJson());
  }
}

import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<void> register({required RegisterRequestParameters request});

  Future<void> verifyEmail({
    required String email,
    required String otp,
  });

  Future<UserModel> getCurrentUser();

  Future<void> logout();
}

import '../models/login_response.dart';
import '../models/register_request.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<void> register({required RegisterRequestParameters request});
}

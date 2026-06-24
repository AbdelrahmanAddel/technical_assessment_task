import '../models/login_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
}

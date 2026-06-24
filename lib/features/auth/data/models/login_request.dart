import '../../../../core/constant/api_strings.dart';

final class LoginRequest {
  const LoginRequest({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {ApiKeys.email: email, ApiKeys.password: password};
  }
}

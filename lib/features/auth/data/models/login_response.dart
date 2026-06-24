import '../../../../core/constant/api_strings.dart';

final class LoginResponse {
  const LoginResponse({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json[ApiKeys.accessToken] as String,
      expiresAtUtc: DateTime.parse(json[ApiKeys.expiresAtUtc] as String),
      refreshToken: json[ApiKeys.refreshToken] as String,
    );
  }
}

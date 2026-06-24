import '../../domain/entities/auth_session.dart';
import '../models/login_response.dart';

abstract final class AuthMapper {
  static AuthSession toEntity(LoginResponse response) {
    return AuthSession(
      accessToken: response.accessToken,
      expiresAtUtc: response.expiresAtUtc,
      refreshToken: response.refreshToken,
    );
  }
}

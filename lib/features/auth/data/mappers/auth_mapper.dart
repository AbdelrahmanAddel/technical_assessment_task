import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';

abstract final class AuthMapper {
  static AuthSession toEntity(LoginResponse response) {
    return AuthSession(
      accessToken: response.accessToken,
      expiresAtUtc: response.expiresAtUtc,
      refreshToken: response.refreshToken,
    );
  }

  static User toUserEntity(UserModel model) {
    return User(
      userId: model.userId,
      email: model.email,
      fullName: model.fullName,
      profilePicture: model.profilePicture,
    );
  }
}

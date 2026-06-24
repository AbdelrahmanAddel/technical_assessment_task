final class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  final String accessToken;
  final DateTime expiresAtUtc;
  final String refreshToken;
}

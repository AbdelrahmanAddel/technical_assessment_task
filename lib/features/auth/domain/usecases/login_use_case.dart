import '../../../../core/api/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

final class LoginUseCase {
  const LoginUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Result<AuthSession>> call({
    required String email,
    required String password,
  }) {
    return authRepository.login(email: email, password: password);
  }
}

import '../../../../core/api/result.dart';
import '../repositories/auth_repository.dart';

final class LogoutUseCase {
  const LogoutUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Result<void>> call() => authRepository.logout();
}

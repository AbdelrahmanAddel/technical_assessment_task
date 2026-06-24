import '../repositories/auth_repository.dart';

final class CheckAuthUseCase {
  const CheckAuthUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<bool> call() {
    return authRepository.hasCachedToken();
  }
}

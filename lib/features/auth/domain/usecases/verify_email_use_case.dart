import '../../../../core/api/result.dart';
import '../repositories/auth_repository.dart';

final class VerifyEmailUseCase {
  const VerifyEmailUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Result<void>> call({
    required String email,
    required String otp,
  }) {
    return authRepository.verifyEmail(email: email, otp: otp);
  }
}

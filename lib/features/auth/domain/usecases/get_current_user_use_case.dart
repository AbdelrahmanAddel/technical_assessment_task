import '../../../../core/api/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

final class GetCurrentUserUseCase {
  const GetCurrentUserUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Result<User>> call() => authRepository.getCurrentUser();
}

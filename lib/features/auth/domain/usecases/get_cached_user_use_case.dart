import '../entities/user.dart';
import '../repositories/auth_repository.dart';

final class GetCachedUserUseCase {
  const GetCachedUserUseCase({required this.authRepository});

  final AuthRepository authRepository;

  User? call() => authRepository.getCachedUser();
}

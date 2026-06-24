import 'package:flutter_techincal_test/features/auth/data/models/register_request.dart';

import '../../../../core/api/result.dart';
import '../repositories/auth_repository.dart';

final class RegisterUseCase {
  const RegisterUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<Result<void>> call({required RegisterRequestParameters request}) {
    return authRepository.register(request: request);
  }
}

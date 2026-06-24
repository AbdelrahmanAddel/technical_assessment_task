import 'package:flutter_techincal_test/features/auth/data/models/register_request.dart';

import '../../../../core/api/result.dart';
import '../entities/auth_session.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> register({required RegisterRequestParameters request});

  Future<Result<void>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<bool> hasCachedToken();
}

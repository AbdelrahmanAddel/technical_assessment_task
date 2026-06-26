import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/core/api/result.dart';
import 'package:flutter_techincal_test/core/errors/failures.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/logout_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_auth_repository.dart';
import '../../helpers/profile_test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogoutUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LogoutUseCase(authRepository: mockAuthRepository);
  });

  group('LogoutUseCase', () {
    test('should return success when repository logout succeeds', () async {
      when(() => mockAuthRepository.logout())
          .thenAnswer((_) async => const Success(null));

      final result = await useCase();

      expect(result.isSuccess, isTrue);
      verify(() => mockAuthRepository.logout()).called(1);
    });

    test('should return failure when repository logout fails', () async {
      const failure = ServerFailure(errMessage: tFailureMessage);

      when(() => mockAuthRepository.logout())
          .thenAnswer((_) async => const FailureResult(failure));

      final result = await useCase();

      expect(result.isFailure, isTrue);
      expect(result.failureOrNull?.errMessage, tFailureMessage);
      verify(() => mockAuthRepository.logout()).called(1);
    });
  });
}

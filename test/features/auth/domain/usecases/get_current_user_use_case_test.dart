import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/core/api/result.dart';
import 'package:flutter_techincal_test/core/errors/failures.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_auth_repository.dart';
import '../../helpers/profile_test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCurrentUserUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetCurrentUserUseCase(authRepository: mockAuthRepository);
  });

  group('GetCurrentUserUseCase', () {
    test('should return user when repository succeeds', () async {
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Success(tUser));

      final result = await useCase();

      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, tUser);
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });

    test('should return failure when repository fails', () async {
      const failure = ServerFailure(errMessage: tFailureMessage);

      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const FailureResult(failure));

      final result = await useCase();

      expect(result.isFailure, isTrue);
      expect(result.failureOrNull?.errMessage, tFailureMessage);
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
    });
  });
}

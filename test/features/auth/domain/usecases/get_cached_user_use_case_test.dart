import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/get_cached_user_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_auth_repository.dart';
import '../../helpers/profile_test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCachedUserUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetCachedUserUseCase(authRepository: mockAuthRepository);
  });

  group('GetCachedUserUseCase', () {
    test('should return cached user when repository has cached data', () {
      when(() => mockAuthRepository.getCachedUser()).thenReturn(tCachedUser);

      final result = useCase();

      expect(result, tCachedUser);
      verify(() => mockAuthRepository.getCachedUser()).called(1);
    });

    test('should return null when repository has no cached data', () {
      when(() => mockAuthRepository.getCachedUser()).thenReturn(null);

      final result = useCase();

      expect(result, isNull);
      verify(() => mockAuthRepository.getCachedUser()).called(1);
    });
  });
}

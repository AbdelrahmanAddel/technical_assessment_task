import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/core/api/result.dart';
import 'package:flutter_techincal_test/core/errors/failures.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/get_cached_user_use_case.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/get_current_user_use_case.dart';
import 'package:flutter_techincal_test/features/auth/domain/usecases/logout_use_case.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_cubit.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_auth_repository.dart';
import '../../helpers/profile_state_matchers.dart';
import '../../helpers/profile_test_fixtures.dart';

void main() {
  late MockAuthRepository mockAuthRepository;

  ProfileCubit createCubit() {
    return ProfileCubit(
      getCachedUserUseCase: GetCachedUserUseCase(
        authRepository: mockAuthRepository,
      ),
      getCurrentUserUseCase: GetCurrentUserUseCase(
        authRepository: mockAuthRepository,
      ),
      logoutUseCase: LogoutUseCase(authRepository: mockAuthRepository),
    );
  }

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('ProfileCubit', () {
    group('loadProfile', () {
      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoading, ProfileLoaded] when there is no cache and fetch succeeds',
        build: () {
          when(() => mockAuthRepository.getCachedUser()).thenReturn(null);
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Success(tUser));
          return createCubit();
        },
        act: (cubit) => cubit.loadProfile(),
        expect: () => [
          const ProfileLoading(),
          isProfileLoaded(user: tUser),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.getCachedUser()).called(1);
          verify(() => mockAuthRepository.getCurrentUser()).called(1);
        },
      );

      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoading, ProfileFailure] when there is no cache and fetch fails',
        build: () {
          when(() => mockAuthRepository.getCachedUser()).thenReturn(null);
          when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
            (_) async => const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit();
        },
        act: (cubit) => cubit.loadProfile(),
        expect: () => [
          const ProfileLoading(),
          isA<ProfileFailure>().having(
            (state) => state.message,
            'message',
            tFailureMessage,
          ),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoaded(isRefreshing), ProfileLoaded] when cache exists and fetch succeeds',
        build: () {
          when(() => mockAuthRepository.getCachedUser()).thenReturn(tCachedUser);
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Success(tUser));
          return createCubit();
        },
        act: (cubit) => cubit.loadProfile(),
        expect: () => [
          isProfileLoaded(user: tCachedUser, isRefreshing: true),
          isProfileLoaded(user: tUser),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoaded(isRefreshing), ProfileLoaded] when cache exists and fetch fails',
        build: () {
          when(() => mockAuthRepository.getCachedUser()).thenReturn(tCachedUser);
          when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
            (_) async => const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit();
        },
        act: (cubit) => cubit.loadProfile(),
        expect: () => [
          isProfileLoaded(user: tCachedUser, isRefreshing: true),
          isProfileLoaded(user: tCachedUser),
        ],
      );
    });

    group('refreshProfile', () {
      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoaded(isRefreshing), ProfileLoaded] when profile is already loaded',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Success(tUser));
          return createCubit()..emit(const ProfileLoaded(user: tCachedUser));
        },
        act: (cubit) => cubit.refreshProfile(),
        expect: () => [
          isProfileLoaded(user: tCachedUser, isRefreshing: true),
          isProfileLoaded(user: tUser),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.getCurrentUser()).called(1);
          verifyNever(() => mockAuthRepository.getCachedUser());
        },
      );

      blocTest<ProfileCubit, ProfileState>(
        'should keep cached user when refresh fails',
        build: () {
          when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
            (_) async => const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit()..emit(const ProfileLoaded(user: tCachedUser));
        },
        act: (cubit) => cubit.refreshProfile(),
        expect: () => [
          isProfileLoaded(user: tCachedUser, isRefreshing: true),
          isProfileLoaded(user: tCachedUser),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'should delegate to loadProfile when profile is not loaded',
        build: () {
          when(() => mockAuthRepository.getCachedUser()).thenReturn(null);
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => const Success(tUser));
          return createCubit();
        },
        act: (cubit) => cubit.refreshProfile(),
        expect: () => [
          const ProfileLoading(),
          isProfileLoaded(user: tUser),
        ],
      );
    });

    group('logout', () {
      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoaded(isLoggingOut), ProfileLogoutSuccess] when logout succeeds',
        build: () {
          when(() => mockAuthRepository.logout())
              .thenAnswer((_) async => const Success(null));
          return createCubit()..emit(const ProfileLoaded(user: tUser));
        },
        act: (cubit) => cubit.logout(),
        expect: () => [
          isProfileLoaded(user: tUser, isLoggingOut: true),
          const ProfileLogoutSuccess(),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.logout()).called(1);
        },
      );

      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoaded(isLoggingOut), ProfileLogoutFailure] when logout fails',
        build: () {
          when(() => mockAuthRepository.logout()).thenAnswer(
            (_) async => const FailureResult(
              ServerFailure(errMessage: tFailureMessage),
            ),
          );
          return createCubit()..emit(const ProfileLoaded(user: tUser));
        },
        act: (cubit) => cubit.logout(),
        expect: () => [
          isProfileLoaded(user: tUser, isLoggingOut: true),
          isA<ProfileLogoutFailure>()
              .having((state) => state.user, 'user', tUser)
              .having((state) => state.message, 'message', tFailureMessage),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'should not emit new states when profile is not loaded',
        build: createCubit,
        act: (cubit) => cubit.logout(),
        expect: () => <ProfileState>[],
        verify: (_) {
          verifyNever(() => mockAuthRepository.logout());
        },
      );
    });

    group('restoreProfile', () {
      blocTest<ProfileCubit, ProfileState>(
        'should emit [ProfileLoaded] when user is restored',
        build: createCubit,
        act: (cubit) => cubit.restoreProfile(tUser),
        expect: () => [isProfileLoaded(user: tUser)],
      );
    });
  });
}

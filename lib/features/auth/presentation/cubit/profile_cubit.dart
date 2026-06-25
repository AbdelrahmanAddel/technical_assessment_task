import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_cached_user_use_case.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import 'profile_state.dart';

final class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getCachedUserUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  }) : super(const ProfileInitial());

  final GetCachedUserUseCase getCachedUserUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;

  Future<void> loadProfile() async {
    final cachedUser = getCachedUserUseCase();

    if (cachedUser != null) {
      emit(ProfileLoaded(user: cachedUser, isRefreshing: true));
    } else {
      emit(const ProfileLoading());
    }

    await _fetchProfile(fallbackUser: cachedUser);
  }

  Future<void> refreshProfile() async {
    final currentState = state;

    if (currentState is ProfileLoaded) {
      emit(currentState.copyWith(isRefreshing: true));
      await _fetchProfile(fallbackUser: currentState.user);
      return;
    }

    await loadProfile();
  }

  Future<void> _fetchProfile({User? fallbackUser}) async {
    final result = await getCurrentUserUseCase();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (fallbackUser != null) {
          emit(ProfileLoaded(user: fallbackUser));
          return;
        }
        emit(ProfileFailure(failure.errMessage));
      },
      (user) => emit(ProfileLoaded(user: user)),
    );
  }

  Future<void> logout() async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(currentState.copyWith(isLoggingOut: true));

    final result = await logoutUseCase();

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        ProfileLogoutFailure(
          user: currentState.user,
          message: failure.errMessage,
        ),
      ),
      (_) => emit(const ProfileLogoutSuccess()),
    );
  }

  void restoreProfile(User user) {
    if (isClosed) return;
    emit(ProfileLoaded(user: user));
  }
}

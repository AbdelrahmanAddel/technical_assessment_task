import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import 'profile_state.dart';

final class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  }) : super(const ProfileInitial());

  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());

    final result = await getCurrentUserUseCase();

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProfileFailure(failure.errMessage)),
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

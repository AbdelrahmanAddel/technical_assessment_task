import '../../domain/entities/user.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.user,
    this.isLoggingOut = false,
    this.isRefreshing = false,
  });

  final User user;
  final bool isLoggingOut;
  final bool isRefreshing;

  ProfileLoaded copyWith({
    User? user,
    bool? isLoggingOut,
    bool? isRefreshing,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.message);

  final String message;
}

final class ProfileLogoutSuccess extends ProfileState {
  const ProfileLogoutSuccess();
}

final class ProfileLogoutFailure extends ProfileState {
  const ProfileLogoutFailure({
    required this.user,
    required this.message,
  });

  final User user;
  final String message;
}

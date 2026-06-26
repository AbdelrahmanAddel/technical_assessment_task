import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_techincal_test/features/auth/domain/entities/user.dart';
import 'package:flutter_techincal_test/features/auth/presentation/cubit/profile_state.dart';

Matcher isProfileLoaded({
  required User user,
  bool isRefreshing = false,
  bool isLoggingOut = false,
}) {
  return isA<ProfileLoaded>()
      .having((state) => state.user, 'user', user)
      .having((state) => state.isRefreshing, 'isRefreshing', isRefreshing)
      .having((state) => state.isLoggingOut, 'isLoggingOut', isLoggingOut);
}

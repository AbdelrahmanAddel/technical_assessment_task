import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/storage_keys.dart';
import 'cached_user.dart';

final class AppPrefs {
  AppPrefs(this._prefs);

  final SharedPreferences _prefs;

  ThemeMode get themeMode {
    final value = _prefs.getString(StorageKeys.themeMode);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(StorageKeys.themeMode, mode.name);
  }

  CachedUser? get cachedUser {
    final userId = _prefs.getString(StorageKeys.userId);
    final fullName = _prefs.getString(StorageKeys.userName);
    final email = _prefs.getString(StorageKeys.userEmail);

    if (userId == null || fullName == null || email == null) {
      return null;
    }

    return CachedUser(
      userId: userId,
      fullName: fullName,
      email: email,
      profilePicture:
          _prefs.getString(StorageKeys.userProfilePicture) ?? '',
    );
  }

  Future<void> saveUser({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
  }) async {
    await _prefs.setString(StorageKeys.userId, userId);
    await _prefs.setString(StorageKeys.userName, name);
    await _prefs.setString(StorageKeys.userEmail, email);
    await _prefs.setString(StorageKeys.userProfilePicture, profilePicture);
  }

  Future<void> clearUser() async {
    await _prefs.remove(StorageKeys.userId);
    await _prefs.remove(StorageKeys.userName);
    await _prefs.remove(StorageKeys.userEmail);
    await _prefs.remove(StorageKeys.userProfilePicture);
  }
}

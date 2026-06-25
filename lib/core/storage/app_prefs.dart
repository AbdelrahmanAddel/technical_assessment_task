import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/storage_keys.dart';

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

  String? get userName => _prefs.getString(StorageKeys.userName);

  String? get userEmail => _prefs.getString(StorageKeys.userEmail);

  Future<void> saveUser({
    required String name,
    required String email,
  }) async {
    await _prefs.setString(StorageKeys.userName, name);
    await _prefs.setString(StorageKeys.userEmail, email);
  }

  Future<void> clearUser() async {
    await _prefs.remove(StorageKeys.userName);
    await _prefs.remove(StorageKeys.userEmail);
  }
}

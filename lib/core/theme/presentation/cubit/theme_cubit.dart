import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../storage/app_prefs.dart';

final class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(_prefs.themeMode);

  final AppPrefs _prefs;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;

    emit(mode);
    await _prefs.setThemeMode(mode);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/data/user_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final UserPreferences _preferences;

  ThemeCubit(UserPreferences preferences)
      : _preferences = preferences,
        super(preferences.getTheme());

  void changue(ThemeMode mode) async {
    await _preferences.setTheme(mode);
    emit(mode);
  }
}

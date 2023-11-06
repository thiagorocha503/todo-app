import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/theme/preferences/theme_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemePreferences preferences;
  ThemeCubit({required this.preferences, required ThemeMode theme})
      : super(theme) {
    preferences.stream.listen((theme) {
      emit(theme);
    });
  }

  void changue(ThemeMode theme) {
    preferences.setTheme(theme);
  }
}

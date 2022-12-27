import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/theme/model/app_theme.dart';
import 'package:todo/theme/preferences/theme_preferences.dart';

class ThemeCubit extends Cubit<AppTheme> {
  ThemePreferences preferences;
  ThemeCubit({required this.preferences, required AppTheme theme})
      : super(theme) {
    preferences.stream.listen((theme) {
      emit(theme);
    });
  }

  void changue(AppTheme theme) {
    preferences.setTheme(theme);
  }
}

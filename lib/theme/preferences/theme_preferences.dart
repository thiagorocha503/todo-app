import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/theme/model/app_theme.dart';

class ThemePreferences {
  final SharedPreferences preferences;
  // ignore: non_constant_identifier_names
  final KEY = "todo-theme";

  final StreamController<AppTheme> _controller = StreamController();

  Stream<AppTheme> get stream => _controller.stream;

  ThemePreferences({required this.preferences});

  AppTheme getTheme() {
    int? index = preferences.getInt(KEY);
    if (index != null) {
      return AppTheme.values[index];
    }
    setTheme(AppTheme.light);
    return AppTheme.light;
  }

  void setTheme(AppTheme theme) {
    preferences.setInt(KEY, theme.index);
    _controller.sink.add(theme);
  }
}

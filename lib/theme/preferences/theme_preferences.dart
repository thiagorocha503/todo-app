import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateNiceMocks([MockSpec<ThemePreferences>()])
class ThemePreferences {
  final SharedPreferences preferences;
  // ignore: non_constant_identifier_names
  final KEY = "todo-theme";

  final StreamController<ThemeMode> _controller = StreamController();

  Stream<ThemeMode> get stream => _controller.stream;

  ThemePreferences({required this.preferences});

  ThemeMode getTheme() {
    int? index = preferences.getInt(KEY);
    if (index != null) {
      return ThemeMode.values[index];
    }
    setTheme(ThemeMode.light);
    return ThemeMode.light;
  }

  void setTheme(ThemeMode theme) {
    preferences.setInt(KEY, theme.index);
    _controller.sink.add(theme);
  }
}

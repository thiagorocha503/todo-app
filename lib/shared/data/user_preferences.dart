import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants.dart';

class UserPreferences {
  final SharedPreferences _preferecense;
  UserPreferences(SharedPreferences preferecense)
      : _preferecense = preferecense;

  ThemeMode getTheme() {
    int? index = _preferecense.getInt(themeModePreferences);
    if (index == null) {
      _preferecense.setInt(themeModePreferences, ThemeMode.light.index);
      return ThemeMode.light;
    }
    return ThemeMode.values[index];
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _preferecense.setInt(themeModePreferences, mode.index);
  }

  Locale getLocale() {
    String? code = _preferecense.getString(localeLanguageCode);
    if (code == null) {
      _preferecense.setString(localeLanguageCode, "en");
      return const Locale("en");
    }
    return Locale(code);
  }

  Future<void> setLocale(Locale locale) async {
    _preferecense.setString(localeLanguageCode, locale.languageCode);
  }

  bool getShowComplete() {
    bool? show = _preferecense.getBool(showCompletePreferences);
    if (show == null) {
      _preferecense.setBool(showCompletePreferences, false);
      return false;
    }

    return show;
  }

  void setShowComplete(bool show) {
    _preferecense.setBool(showCompletePreferences, show);
  }

  List<String> getHistories() {
    List<String>? histories = _preferecense.getStringList(historyPreferences);
    if (histories == null) {
      _preferecense.setStringList(historyPreferences, const []);
      return [];
    }
    return histories;
  }

  void addHistory(String query) async {
    List<String> list = getHistories();
    if (!list.contains(query.toLowerCase())) {
      await _preferecense.setStringList(historyPreferences, [query, ...list]);
    }
  }

  void clearHistory() {
    _preferecense.setStringList(historyPreferences, []);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalePreferences {
  SharedPreferences preferences;
  LocalePreferences({required this.preferences});

  void setLocale(Locale locale) {
    preferences.setString('language_code', locale.languageCode);
  }

  Locale getLocale() {
    if (preferences.getString('language_code') == null) {
      preferences.setString('language_code', 'en');
    }
    return Locale(preferences.getString('language_code')!);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/data/user_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final UserPreferences _preferences;

  LocaleCubit(UserPreferences preferences)
    : _preferences = preferences,
      super(preferences.getLocale());

  Future<void> change(Locale locale) async {
    if (locale == state) {
      return;
    }
    await _preferences.setLocale(locale);
    emit(locale);
  }
}

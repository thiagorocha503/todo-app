import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/locale/preferences/locale_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final LocalePreferences preferences;

  LocaleCubit({required this.preferences, required Locale locale})
      : super(locale);

  void change(Locale locale) {
    preferences.setLocale(locale);
    emit(locale);
  }
}

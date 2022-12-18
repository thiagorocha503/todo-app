import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/language/model/language.dart';
import 'package:todo/language/preferences/language_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  final LanguagePreferences preferences;

  LanguageCubit({required this.preferences, required String code})
      : super(Locale(code)) {
    preferences.stream.listen((code) {
      emit(Locale(code.name));
    });
  }

  void change(Language languague) {
    preferences.language = languague;
  }
}

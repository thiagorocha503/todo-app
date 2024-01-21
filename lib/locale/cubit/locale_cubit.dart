import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/data/user_preferences.dart';

class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({required this.locale});

  @override
  List<Object?> get props => [locale.languageCode];
}

class LocaleCubit extends Cubit<LocaleState> {
  final UserPreferences _preferences;

  LocaleCubit(UserPreferences preferences)
      : _preferences = preferences,
        super(LocaleState(locale: preferences.getLocale()));

  void change(Locale locale) async {
    await _preferences.setLocale(locale);
    emit(LocaleState(locale: locale));
  }
}

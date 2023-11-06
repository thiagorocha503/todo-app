import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/preferences/theme_preferences.dart';
import 'theme_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ThemePreferences>()])
void main() {
  ThemePreferences preferences = MockThemePreferences();

  blocTest<ThemeCubit, ThemeMode>(
    "Change theme to dark",
    build: () => ThemeCubit(preferences: preferences, theme: ThemeMode.light),
    setUp: () {
      when(preferences.stream).thenAnswer((_) => Stream.value(ThemeMode.dark));
    },
    act: (cubit) => cubit.changue(ThemeMode.dark),
    verify: (_) {
      verify(preferences.stream);
      verify(preferences.setTheme(ThemeMode.dark));
    },
    expect: () => <ThemeMode>[ThemeMode.dark],
  );

  blocTest<ThemeCubit, ThemeMode>(
    "Change theme to light",
    build: () => ThemeCubit(preferences: preferences, theme: ThemeMode.dark),
    setUp: () {
      when(preferences.stream).thenAnswer((_) => Stream.value(ThemeMode.light));
    },
    act: (cubit) => cubit.changue(ThemeMode.light),
    verify: (_) {
      verify(preferences.stream);
      verify(preferences.setTheme(ThemeMode.light));
    },
    expect: () => <ThemeMode>[ThemeMode.light],
  );

  blocTest<ThemeCubit, ThemeMode>(
    "Change theme to system",
    build: () => ThemeCubit(preferences: preferences, theme: ThemeMode.dark),
    setUp: () {
      when(preferences.stream)
          .thenAnswer((_) => Stream.value(ThemeMode.system));
    },
    act: (cubit) => cubit.changue(ThemeMode.system),
    verify: (_) {
      verify(preferences.stream);
      verify(preferences.setTheme(ThemeMode.system));
    },
    expect: () => <ThemeMode>[ThemeMode.system],
  );
}

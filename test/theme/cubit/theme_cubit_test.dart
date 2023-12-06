import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/shared/data/user_preferences.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';

class MockUserPreferences extends Mock implements UserPreferences {}

void main() {
  late UserPreferences preferences;

  setUp(() {
    preferences = MockUserPreferences();
    when(() => preferences.setTheme(ThemeMode.dark)).thenAnswer((_) async {});
    when(() => preferences.setTheme(ThemeMode.light)).thenAnswer((_) async {});
    when(() => preferences.setTheme(ThemeMode.system)).thenAnswer((_) async {});
  });

  blocTest<ThemeCubit, ThemeMode>(
    "Change theme to dark",
    build: () => ThemeCubit(preferences),
    setUp: () {
      when(() => preferences.getTheme()).thenAnswer((_) => ThemeMode.light);
    },
    act: (cubit) => cubit.changue(ThemeMode.dark),
    verify: (_) {
      verify(() => preferences.setTheme(ThemeMode.dark)).called(1);
    },
    expect: () => <ThemeMode>[ThemeMode.dark],
  );

  blocTest<ThemeCubit, ThemeMode>(
    "Change theme to light",
    build: () => ThemeCubit(
      preferences,
    ),
    act: (cubit) => cubit.changue(ThemeMode.light),
    setUp: () {
      when(() => preferences.getTheme()).thenAnswer((_) => ThemeMode.dark);
    },
    verify: (_) {
      verify(() => preferences.setTheme(ThemeMode.light)).called(1);
    },
    expect: () => <ThemeMode>[ThemeMode.light],
  );

  blocTest<ThemeCubit, ThemeMode>(
    "Change theme to system",
    build: () => ThemeCubit(preferences),
    setUp: () {
      when(() => preferences.getTheme()).thenAnswer((_) => ThemeMode.dark);
    },
    act: (cubit) => cubit.changue(ThemeMode.system),
    verify: (_) {
      verify(() => preferences.setTheme(ThemeMode.system)).called(1);
    },
    expect: () => <ThemeMode>[ThemeMode.system],
  );
}

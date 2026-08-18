import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/shared/data/user_preferences.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';

class MockUserPreferences extends Mock implements UserPreferences {}

void main() {
  late UserPreferences preferences;

  group("theme cubit", () {
    const initialTheme = ThemeMode.system;

    setUp(() {
      preferences = MockUserPreferences();
    });

    setUpAll(() {
      registerFallbackValue(ThemeMode.system);
    });

    test('should initialize with theme loaded from UserPreferences', () {
      when(() => preferences.getTheme()).thenReturn(initialTheme);

      final cubit = ThemeCubit(preferences);

      expect(cubit.state, equals(initialTheme));
      verify(() => preferences.getTheme()).called(1);
    });
    group('changeTheme', () {
      blocTest<ThemeCubit, ThemeMode>(
        "Change theme to dark",
        build: () => ThemeCubit(preferences),
        setUp: () {
          when(() => preferences.getTheme()).thenAnswer((_) => ThemeMode.light);
          when(
            () => preferences.setTheme(ThemeMode.dark),
          ).thenAnswer((_) async {});
        },
        act: (cubit) => cubit.changeTheme(ThemeMode.dark),
        verify: (_) {
          verify(() => preferences.setTheme(ThemeMode.dark)).called(1);
        },
        expect: () => <ThemeMode>[ThemeMode.dark],
      );

      blocTest<ThemeCubit, ThemeMode>(
        "Change theme to light",
        build: () => ThemeCubit(preferences),
        setUp: () {
          when(() => preferences.getTheme()).thenReturn(ThemeMode.dark);
          when(
            () => preferences.setTheme(ThemeMode.light),
          ).thenAnswer((_) async {});
        },
        act: (cubit) => cubit.changeTheme(ThemeMode.light),
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
          when(
            () => preferences.setTheme(ThemeMode.system),
          ).thenAnswer((_) async {});
        },
        act: (cubit) => cubit.changeTheme(ThemeMode.system),
        verify: (_) {
          verify(() => preferences.setTheme(ThemeMode.system)).called(1);
        },
        expect: () => <ThemeMode>[ThemeMode.system],
      );

      blocTest<ThemeCubit, ThemeMode>(
        'should not emit a new state or update preferences when changing to current active theme',
        setUp: () {
          when(() => preferences.getTheme()).thenReturn(ThemeMode.dark);
        },
        build: () => ThemeCubit(preferences),
        act: (cubit) => cubit.changeTheme(ThemeMode.dark),
        expect: () => const <ThemeMode>[],
        verify: (_) {
          verifyNever(() => preferences.setTheme(any()));
        },
      );
    });
  });
}

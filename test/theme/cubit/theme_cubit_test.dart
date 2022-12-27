import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/model/app_theme.dart';
import 'package:todo/theme/preferences/theme_preferences.dart';
import 'package:todo/theme/preferences/theme_preferences.mocks.dart';

void main() {
  ThemePreferences preferences = MockThemePreferences();

  blocTest<ThemeCubit, AppTheme>(
    "Change theme to dark",
    build: () => ThemeCubit(preferences: preferences, theme: AppTheme.light),
    setUp: () {
      when(preferences.stream).thenAnswer((_) => Stream.value(AppTheme.dark));
    },
    act: (cubit) => cubit.changue(AppTheme.dark),
    verify: (_) {
      verify(preferences.stream);
      verify(preferences.setTheme(AppTheme.dark));
    },
    expect: () => <AppTheme>[AppTheme.dark],
  );

  blocTest<ThemeCubit, AppTheme>(
    "Change theme to light",
    build: () => ThemeCubit(preferences: preferences, theme: AppTheme.dark),
    setUp: () {
      when(preferences.stream).thenAnswer((_) => Stream.value(AppTheme.light));
    },
    act: (cubit) => cubit.changue(AppTheme.light),
    verify: (_) {
      verify(preferences.stream);
      verify(preferences.setTheme(AppTheme.light));
    },
    expect: () => <AppTheme>[AppTheme.light],
  );

  blocTest<ThemeCubit, AppTheme>(
    "Change theme to system",
    build: () => ThemeCubit(preferences: preferences, theme: AppTheme.dark),
    setUp: () {
      when(preferences.stream).thenAnswer((_) => Stream.value(AppTheme.system));
    },
    act: (cubit) => cubit.changue(AppTheme.system),
    verify: (_) {
      verify(preferences.stream);
      verify(preferences.setTheme(AppTheme.system));
    },
    expect: () => <AppTheme>[AppTheme.system],
  );
}

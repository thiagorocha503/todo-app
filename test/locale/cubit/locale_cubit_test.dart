import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/shared/data/user_preferences.dart';

class MockUserPreferences extends Mock implements UserPreferences {}

class FakeLocale extends Fake implements Locale {}

void main() {
  late UserPreferences preferences;

  setUpAll(() {
    registerFallbackValue(FakeLocale());
  });

  setUp(() {
    preferences = MockUserPreferences();
  });

  group("LocaleCubit", () {
    const initialLocale = Locale('en');

    test('should initialize with locale from UserPreferences', () {
      when(() => preferences.getLocale()).thenReturn(initialLocale);
      final cubit = LocaleCubit(preferences);
      expect(cubit.state, equals(const LocaleState(locale: initialLocale)));
      verify(() => preferences.getLocale()).called(1);
    });
    group("change", () {
      const newLocale = Locale('pt', 'BR');
      blocTest<LocaleCubit, LocaleState>(
        "should emit [LocaleState] with new locale and persist it to preferences",
        build: () => LocaleCubit(preferences),
        setUp: () {
          when(() => preferences.getLocale()).thenReturn(initialLocale);
          when(() => preferences.setLocale(newLocale)).thenAnswer((_) async {});
        },
        act: (cubit) => cubit.change(newLocale),
        verify: (_) {
          verify(() => preferences.setLocale(any())).called(1);
        },
        expect: () => <LocaleState>[const LocaleState(locale: newLocale)],
      );
    });
  });
}

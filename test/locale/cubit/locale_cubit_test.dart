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
    when(() => preferences.getLocale()).thenAnswer((_) => const Locale("en"));
    when(() => preferences.setLocale(any())).thenAnswer((invocation) async {});
  });

  blocTest<LocaleCubit, LocaleState>(
    "Change locale to portugues",
    build: () => LocaleCubit(preferences),
    act: (cubit) => cubit.change(const Locale("pt")),
    verify: (_) {
      verify(() => preferences.setLocale(any())).called(1);
    },
    expect: () => <LocaleState>[const LocaleState(locale: Locale("pt"))],
  );
}

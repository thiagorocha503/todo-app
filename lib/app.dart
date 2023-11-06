import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/filter/bloc/filter_bloc.dart';
import 'package:todo/filter/preferences/filter_preferences.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/language/preferences/language_preferences.dart';
import 'package:todo/subtask/repository/repository.dart';
import 'package:todo/subtask/repository/subtask_repository.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/preferences/theme_preferences.dart';
import 'package:todo/theme/ui/widget/theme_data.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/repository/repository.dart';
import 'package:todo/todo_over_view/repository/todo_repository.dart';
import 'package:todo/todo_over_view/ui/todo_overview_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/app_localizations.dart';

class App extends StatelessWidget {
  final SharedPreferences preferences;
  const App({required this.preferences, super.key});

  @override
  Widget build(BuildContext context) {
    ITodoRepository todoRepository = TodoRepository();
    ISubtaskRepository subtaskRepository = SubtaskRepository();
    LanguagePreferences localePreferences = LanguagePreferences(
      preferences: preferences,
    );
    FilterPreferences filterPreferences = FilterPreferences(
      preferences: preferences,
    );
    ThemePreferences themePreferences = ThemePreferences(
      preferences: preferences,
    );

    TodoOverviewBloc todoOverViewBloc = TodoOverviewBloc(
      filter: filterPreferences.filter,
      repository: todoRepository,
    )..add(TodoOverviewFetchEvent());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ITodoRepository>(
          create: (context) => todoRepository,
        ),
        RepositoryProvider<ISubtaskRepository>(
          create: (context) => subtaskRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(
              preferences: themePreferences,
              theme: themePreferences.getTheme(),
            ),
          ),
          BlocProvider<FilterCubit>(
            create: (context) => FilterCubit(
              preferences: filterPreferences,
              bloc: todoOverViewBloc,
              filter: filterPreferences.filter,
            ),
          ),
          BlocProvider<LanguageCubit>(
            create: (context) => LanguageCubit(
              preferences: localePreferences,
              code: localePreferences.language.name,
            ),
          ),
          BlocProvider<TodoOverviewBloc>(
            create: (BuildContext context) => todoOverViewBloc,
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (conttext, ThemeMode themeMode) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, Locale locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Tasks',
                themeMode: themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                home: const TodoOverviewPage(),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                locale: locale,
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('pt', ''),
                  Locale('es', '')
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

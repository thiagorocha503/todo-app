import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/filter/bloc/filter_bloc.dart';
import 'package:todo/filter/preferences/filter_preferences.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/language/preferences/language_preferences.dart';
import 'package:todo/subtask/repository/repository.dart';
import 'package:todo/subtask/repository/subtask_repository.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/repository/repository.dart';
import 'package:todo/todo_over_view/repository/todo_repository.dart';
import 'package:todo/todo_over_view/ui/todo_over_view_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/app_localizations.dart';

class App extends StatelessWidget {
  final SharedPreferences preferences;
  const App({required this.preferences, super.key});

  @override
  Widget build(BuildContext context) {
    ITodoRepository todoRepository = TodoRepository();
    ISubtaskRepository subtaskRepository = SubtaskRepository();
    LanguagePreferences localePreferences =
        LanguagePreferences(preferences: preferences);
    FilterPreferences filterPreferences =
        FilterPreferences(preferences: preferences);

    TodoOverViewBloc todoOverViewBloc = TodoOverViewBloc(
      filter: filterPreferences.filter,
      repository: todoRepository,
    )..add(TodoOverViewFetchEvent());
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
          BlocProvider<TodoOverViewBloc>(
            create: (BuildContext context) => todoOverViewBloc,
          ),
        ],
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, Locale locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tasks',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const TodoOverViewPage(),
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
        ),
      ),
    );
  }
}

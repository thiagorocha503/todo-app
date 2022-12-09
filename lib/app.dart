import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/filter/bloc/filter_bloc.dart';
import 'package:todo/filter/preferences/filter_preferences.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/locale/preferences/locale_preferences.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/repository/todo_repository.dart';
import 'package:todo/todo_over_view/ui/todo_over_view_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/app_localizations.dart';

class App extends StatelessWidget {
  final SharedPreferences preferences;
  const App({required this.preferences, super.key});

  @override
  Widget build(BuildContext context) {
    TodoRepository repository = TodoRepository();
    LocalePreferences localePreferences =
        LocalePreferences(preferences: preferences);
    FilterPreferences filterPreferences =
        FilterPreferences(preferences: preferences);

    TodoOverViewBloc todoOverViewBloc = TodoOverViewBloc(
      filter: filterPreferences.getFilter(),
      repository: repository,
    )..add(TodoOverViewFetchEvent());
    return RepositoryProvider(
      create: (context) => repository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider<FilterCubit>(
              create: (context) => FilterCubit(
                preferences: filterPreferences,
                bloc: todoOverViewBloc,
                filter: filterPreferences.getFilter(),
              ),
            ),
            BlocProvider<LocaleCubit>(
              create: (context) => LocaleCubit(
                preferences: localePreferences,
                locale: localePreferences.getLocale(),
              ),
            ),
            BlocProvider<TodoOverViewBloc>(
              create: (BuildContext context) => todoOverViewBloc,
            ),
          ],
          child: BlocBuilder<LocaleCubit, Locale>(
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
          )),
    );
  }
}

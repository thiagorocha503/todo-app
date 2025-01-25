import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/database/database.dart';
import 'package:todo/history/bloc/bloc.dart';
import 'package:todo/home/home_page.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/data/listing_database.dart';
import 'package:todo/list_overview/respository/listing_repository.dart';
import 'package:todo/locale/cubit/locale_cubit.dart';
import 'package:todo/selectable_list/bloc/selectable_list_bloc.dart';
import 'package:todo/selectable_list/bloc/selectable_list_state.dart';
import 'package:todo/shared/data/user_preferences.dart';
import 'package:todo/subtask/data/subtask_database.dart';
import 'package:todo/subtask/repository/subtask_repository.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/ui/widget/theme.dart';
import 'package:todo/todo_overview/data/todo_database.dart';
import 'package:todo/todo_overview/respository/todo_repository.dart';

import 'generated/l10n.dart';

class App extends StatelessWidget {
  final SharedPreferences preferences;
  const App({required this.preferences, super.key});

  @override
  Widget build(BuildContext context) {
    TodoLocalDatabase todoDB = TodoLocalDatabase(
      DatabaseService.getInstance(),
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserPreferences>(
          create: (_) => UserPreferences(preferences),
        ),
        RepositoryProvider<ListingRespository>(
          create: (_) => ListingRespository(
            ListingLocalDatabase(DatabaseService.getInstance(), todoDB),
          ),
        ),
        RepositoryProvider<TodoRepository>(
          create: (_) => TodoRepository(
            todoDB,
          ),
        ),
        RepositoryProvider<SubtaskRepository>(
          create: (_) => SubtaskRepository(
            SubtaskLocalDatabase(
              DatabaseService.getInstance(),
            ),
          ),
        ),
      ],
      child: Builder(
        builder: (context) => MultiBlocProvider(
          // bloc providers
          providers: [
            BlocProvider<HistoricBloc>(
              create: (_) => HistoricBloc(RepositoryProvider.of(context)),
            ),
            BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(RepositoryProvider.of(context)),
            ),
            BlocProvider<LocaleCubit>(
              create: (context) => LocaleCubit(RepositoryProvider.of(context)),
            ),
            BlocProvider<ListingOverviewBloc>(
              create: (_) => ListingOverviewBloc(
                const ListingOverviewInitialState(list: []),
                todoRepository: RepositoryProvider.of(context),
                listRepository: RepositoryProvider.of(context),
              )..add(
                  ListingOverviewListSubscriptionRequested(),
                ),
            ),
            BlocProvider<SelectableListBloc>(
              create: (context) => SelectableListBloc(
                const SelectableListState(enabled: false, itens: []),
              ),
            )
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (conttext, ThemeMode themeMode) =>
                BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, LocaleState state) => DynamicColorBuilder(
                builder: (lightColorScheme, darkColorScheme) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Tasks',
                  themeMode: themeMode,
                  home: const HomePage(),
                  theme: ThemeData(
                    colorScheme:
                        lightColorScheme ?? MaterialTheme.lightScheme(),
                  ),
                  darkTheme: ThemeData(
                    colorScheme: darkColorScheme ?? MaterialTheme.darkScheme(),
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  locale: Locale(state.locale.languageCode),
                  supportedLocales: AppLocalizations.delegate.supportedLocales,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

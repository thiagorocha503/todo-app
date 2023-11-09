import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/constants/keys.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';
import 'package:todo/todo_over_view/repository/todo_repository.mocks.dart';
import 'package:todo/todo_over_view/ui/todo_overview_page.dart';
import 'package:todo/todo_over_view/ui/widget/todo_overview_list_tile.dart';
import 'package:todo/widget/error_dialog.dart';

Widget buildApp(ITodoRepository repository, Filter filter) {
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider<ITodoRepository>(create: (context) => repository)
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TodoOverviewBloc(filter: filter, repository: repository)
                ..add(
                  TodoOverviewFetchEvent(),
                ),
        )
      ],
      child: const MaterialApp(
        home: TodoOverviewPage(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: Locale('en', ''),
        supportedLocales: [
          Locale('en', ''),
        ],
      ),
    ),
  );
}

var now = DateTime.now();
List<Todo> data = [
  const Todo(id: 1, name: "one", completeDate: null),
  Todo(id: 2, name: "two", completeDate: DateTime(now.year)),
  const Todo(id: 3, name: "three", completeDate: null)
];

void main() {
  late MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    when(repository.fetch(filter: Filter.all)).thenAnswer(
      (_) => Future.value(List.from(data)),
    );
    when(repository.fetch(filter: Filter.done)).thenAnswer(
      (_) => Future.value(
        data.where((todo) => todo.completeDate != null).toList(),
      ),
    );
    when(repository.fetch(filter: Filter.active)).thenAnswer(
      (_) => Future.value(
        data.where((todo) => todo.completeDate == null).toList(),
      ),
    );
  });

  group("Fetch ", () {
    testWidgets("filter All", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(find.text("one"), findsOneWidget);
        expect(find.text("two"), findsOneWidget);
        expect(find.text("three"), findsOneWidget);
      });
    });

    testWidgets("filter done", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.done));
        await tester.pumpAndSettle();
        expect(find.text("one"), findsNothing);
        expect(find.text("two"), findsOneWidget);
        expect(find.text("three"), findsNothing);
      });
    });

    testWidgets("filter active", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.active));
        await tester.pumpAndSettle();
        expect(find.text("one"), findsOneWidget);
        expect(find.text("two"), findsNothing);
        expect(find.text("three"), findsOneWidget);
      });
    });

    testWidgets("empty to do", (tester) async {
      await tester.runAsync(() async {
        when(repository.fetch(filter: Filter.all))
            .thenAnswer((_) => Future.value([]));
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(find.byType(TodoOverviewListTile), findsNothing);
        expect(find.text("No tasks"), findsOneWidget);
      });
    });
  });
  group("Add todo", () {
    testWidgets("sucess case", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(find.text("one"), findsOneWidget);
        expect(find.text("two"), findsOneWidget);
        expect(find.text("three"), findsOneWidget);

        await tester.tap(find.byKey(const Key(TODO_ADD_ICON_BUTTON)));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(const Key(TODO_NEW_INPUT)), "four");
        await tester.pumpAndSettle();

        when(repository.fetch(filter: Filter.all)).thenAnswer((_) =>
            Future.value(
                List.from(data)..add(const Todo(id: 4, name: "four"))));
        await tester.tap(find.byKey(const Key(TODO_SAVE_ICON_BUTTON)));
        await tester.pumpAndSettle();

        expect(find.text("one"), findsOneWidget);
        expect(find.text("two"), findsOneWidget);
        expect(find.text("three"), findsOneWidget);
        expect(find.text("four"), findsOneWidget);
      });
    });

    testWidgets("error case", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(find.text("one"), findsOneWidget);
        expect(find.text("two"), findsOneWidget);
        expect(find.text("three"), findsOneWidget);

        await tester.tap(find.byKey(const Key(TODO_ADD_ICON_BUTTON)));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(const Key(TODO_NEW_INPUT)), "four");
        await tester.pumpAndSettle();

        when(repository.insert(any)).thenThrow(Exception("Add to do failed"));
        await tester.tap(find.byKey(const Key(TODO_SAVE_ICON_BUTTON)));
        await tester.pumpAndSettle();

        expect(find.byType(ErrorDialog), findsOneWidget);
        expect(find.text("Add to do failed"), findsOneWidget);
        expect(find.text("one"), findsOneWidget);
        expect(find.text("two"), findsOneWidget);
        expect(find.text("three"), findsOneWidget);
        expect(find.text("four"), findsNothing);
      });
    });
  });

  group("todo checkbox", () {
    testWidgets("check sucess case", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);

        when(repository.fetch(filter: Filter.all)).thenAnswer(
          (_) => Future.value(List.from(data)
            ..removeAt(0)
            ..add(Todo(id: 1, name: "one", completeDate: DateTime.now()))),
        );
        await tester.tap(find.byKey(const Key("$TODO_CHECKBOX-1")));
        await tester.pumpAndSettle();
        expect(findRoundCheckBox(tester, 1).isChecked, true);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);
      });
    });

    testWidgets("check error case", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);

        when(repository.update(any)).thenThrow(
          Exception("Error"),
        );

        await tester.tap(find.byKey(const Key("$TODO_CHECKBOX-1")));
        await tester.pumpAndSettle();

        expect(find.byType(ErrorDialog), findsOneWidget);

        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);
      });
    });
    testWidgets("uncheck success case", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);

        when(repository.fetch(filter: Filter.all)).thenAnswer(
          (_) => Future.value(List.from(data)
            ..removeAt(1)
            ..add(const Todo(id: 2, name: "one", completeDate: null))),
        );
        await tester.tap(find.byKey(const Key("$TODO_CHECKBOX-2")));
        await tester.pumpAndSettle();
        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, false);
        expect(findRoundCheckBox(tester, 3).isChecked, false);
      });
    });
    testWidgets("uncheck error case", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildApp(repository, Filter.all));
        await tester.pumpAndSettle();
        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);

        when(repository.update(any)).thenThrow(
          Exception("Error"),
        );
        await tester.tap(find.byKey(const Key("$TODO_CHECKBOX-2")));
        await tester.pumpAndSettle();

        expect(findRoundCheckBox(tester, 1).isChecked, false);
        expect(findRoundCheckBox(tester, 2).isChecked, true);
        expect(findRoundCheckBox(tester, 3).isChecked, false);
      });
    });
  });
}

RoundCheckBox findRoundCheckBox(WidgetTester tester, int id) {
  Finder finder = find.byKey(Key("$TODO_CHECKBOX-$id"));
  return tester.firstWidget(finder) as RoundCheckBox;
}

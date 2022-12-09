import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';

import '../mock/todo_repository_mok.dart';

void main() {
  late Bloc bloc;
  group("Todo", () {
    setUp(() {
      bloc = TodoOverViewBloc(
          filter: Filter.all, repository: TodoRepositoryMock());
    });
    blocTest(
      "Get ",
      build: () => bloc,
      act: (bloc) => bloc.add(
        TodoOverViewFetchEvent(),
      ),
      expect: () => [
        TodoOverViewLoadingState(),
        TodoOverViewLoadedState(todos: [
          Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
          ),
          Todo(
            id: 2,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
            completeDate: DateTime(DateTime.now().year, 3, 15),
          ),
          Todo(
            id: 3,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
          ),
        ])
      ],
    );

    blocTest(
      "delete ",
      build: () => bloc,
      act: (bloc) => bloc.add(
        TodoOverViewDeleted(id: 2),
      ),
      expect: () => [
        TodoOverViewLoadingState(),
        TodoOverViewLoadedState(todos: [
          Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
          ),
          Todo(
            id: 3,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
          ),
        ])
      ],
    );

    blocTest(
      "insert ",
      build: () => bloc,
      act: (bloc) => bloc.add(
        TodoOverViewAdded(
          todo: Todo(
            name:
                "laboriosam mollitia et enim quasi adipisci quia provident illum",
            createdDate: DateTime(
              DateTime.now().year,
              6,
              20,
            ),
          ),
        ),
      ),
      expect: () => [
        TodoOverViewLoadingState(),
        TodoOverViewLoadedState(todos: [
          Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
          ),
          Todo(
            id: 2,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
            completeDate: DateTime(DateTime.now().year, 3, 15),
          ),
          Todo(
            id: 3,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
          ),
          Todo(
            id: 4,
            name:
                "laboriosam mollitia et enim quasi adipisci quia provident illum",
            createdDate: DateTime(
              DateTime.now().year,
              6,
              20,
            ),
          ),
        ])
      ],
    );

    blocTest(
      "Todo checked",
      build: () => bloc,
      act: (bloc) => bloc.add(
        TodoOverViewUpdate(
          todo: Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
            completeDate: DateTime(DateTime.now().year, 2, 20),
          ),
        ),
      ),
      expect: () => [
        TodoOverViewLoadedState(todos: [
          Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
            completeDate: DateTime(DateTime.now().year, 2, 20),
          ),
          Todo(
            id: 2,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
            completeDate: DateTime(DateTime.now().year, 3, 15),
            dueDate: null,
          ),
          Todo(
            id: 3,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
          ),
        ])
      ],
    );

    blocTest(
      "Todo unchecked",
      build: () => bloc,
      act: (bloc) => bloc.add(
        TodoOverViewUpdate(
          todo: Todo(
            id: 2,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
            completeDate: null,
          ),
        ),
      ),
      expect: () => [
        TodoOverViewLoadedState(todos: [
          Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
            completeDate: null,
          ),
          Todo(
            id: 2,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
            completeDate: null,
          ),
          Todo(
            id: 3,
            name: "quis ut nam facilis et officia qui",
            createdDate: DateTime(DateTime.now().year, 2, 1),
          ),
        ])
      ],
    );
  });
}

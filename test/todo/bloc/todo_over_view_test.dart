import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';
import 'package:todo/todo_over_view/repository/todo_repository.mocks.dart';

void main() {
  late Bloc bloc;
  late ITodoRepository repository;

  final List<Todo> todos = [
    Todo(
      id: 1,
      name: "delectus aut autem",
      createdDate: DateTime(DateTime.now().year, 1, 1),
      completeDate: null,
      dueDate: null,
    ),
    Todo(
      id: 2,
      name: "fugiat veniam minus",
      createdDate: DateTime(DateTime.now().year, 2, 1),
      completeDate: DateTime(DateTime.now().year, 3, 15),
      dueDate: null,
    ),
    Todo(
      id: 3,
      name: "et porro tempora",
      createdDate: DateTime(DateTime.now().year, 2, 1),
      dueDate: null,
    ),
  ];

  setUp(() {
    repository = MockTodoRepository();
    when(repository.fetch(filter: Filter.all))
        .thenAnswer((realInvocation) async {
      return Future.value(todos);
    });
    bloc = TodoOverViewBloc(
      filter: Filter.all,
      repository: repository,
    );
  });

  blocTest(
    "Fetched todo event",
    build: () => bloc,
    act: (bloc) => bloc.add(
      TodoOverViewFetchEvent(),
    ),
    verify: (_) {
      verify(repository.fetch(filter: Filter.all));
    },
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
          name: "fugiat veniam minus",
          createdDate: DateTime(DateTime.now().year, 2, 1),
          completeDate: DateTime(DateTime.now().year, 3, 15),
        ),
        Todo(
          id: 3,
          name: "et porro tempora",
          createdDate: DateTime(DateTime.now().year, 2, 1),
        ),
      ])
    ],
  );

  blocTest(
    "Added todo event",
    setUp: () {
      when(repository.fetch(filter: Filter.all))
          .thenAnswer((realInvocation) async {
        return await Future.value([
          Todo(
            id: 1,
            name: "delectus aut autem",
            createdDate: DateTime(DateTime.now().year, 1, 1),
            completeDate: null,
            dueDate: null,
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
            dueDate: null,
          ),
          Todo(
            id: 4,
            name: "et doloremque nulla",
            createdDate: DateTime(DateTime.now().year, 6, 20),
          ),
        ]);
      });
    },
    verify: (_) {
      verify(
        repository.insert(
          Todo(
            id: 4,
            name: "et doloremque nulla",
            createdDate: DateTime(DateTime.now().year, 6, 20),
          ),
        ),
      );
      verify(repository.fetch(filter: Filter.all));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(
      TodoOverViewAdded(
        todo: Todo(
          id: 4,
          name: "et doloremque nulla",
          createdDate: DateTime(DateTime.now().year, 6, 20),
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
          completeDate: null,
          dueDate: null,
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
          dueDate: null,
        ),
        Todo(
          id: 4,
          name: "et doloremque nulla",
          createdDate: DateTime(DateTime.now().year, 6, 20),
        ),
      ])
    ],
  );

  blocTest(
    "Deleted todo event",
    build: () => bloc,
    act: (bloc) => bloc.add(
      TodoOverViewDeleted(id: 2),
    ),
    setUp: () {
      when(repository.fetch(filter: Filter.all))
          .thenAnswer((realInvocation) async {
        return await Future.value([
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
        ]);
      });
    },
    verify: (_) {
      verify(repository.delete(2));
      verify(repository.fetch(filter: Filter.all));
    },
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
    "Updated todo event",
    setUp: () {
      when(repository.fetch(filter: Filter.all))
          .thenAnswer((realInvocation) async {
        return Future.value([
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
          )
        ]);
      });
    },
    verify: (_) {
      verify(
        repository.update(Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: DateTime(DateTime.now().year, 2, 20),
        )),
      );
      verify(repository.fetch(filter: Filter.all));
    },
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
}

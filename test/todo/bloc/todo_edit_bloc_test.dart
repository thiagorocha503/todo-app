import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.mocks.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';
import 'package:todo/todo_over_view/repository/todo_repository.mocks.dart';

void main() {
  late TodoEditBloc todoEditbloc;
  late TodoOverviewBloc todoOverviewBloc;
  late ITodoRepository repository;
  final List<Todo> todos = [
    Todo(
      id: 1,
      name: "delectus aut autem",
      createdDate: DateTime(DateTime.now().year, 1, 1),
      completeDate: null,
      dueDate: null,
      note: "lorem ipsum",
    ),
  ];

  setUp(() async {
    repository = MockTodoRepository();
    when(repository.fetch(filter: Filter.all))
        .thenAnswer((realInvocation) async {
      return await Future.value(todos);
    });
    todoOverviewBloc = MockTodoOverviewBloc();
    when(todoOverviewBloc.add(TodoOverviewFetchEvent()))
        .thenAnswer((realInvocation) {});
    todoEditbloc = TodoEditBloc(
      Todo(
        id: 1,
        name: "delectus aut autem",
        createdDate: DateTime(DateTime.now().year, 1, 1),
        completeDate: null,
        dueDate: null,
        note: "lorem ipsum",
      ),
      repository,
      todoOverviewBloc,
    );
  });

  blocTest<TodoEditBloc, TodoEditState>(
    'Title changed event.',
    build: () => todoEditbloc,
    verify: (_) {
      verify(todoOverviewBloc.add(TodoOverviewFetchEvent()));
      verify(repository.update(
        Todo(
          id: 1,
          name: "lorem ipsum",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: null,
          note: "lorem ipsum",
        ),
      ));
    },
    act: (bloc) => bloc.add(const TodoEditTitleChanged(title: "lorem ipsum")),
    expect: () => <TodoEditState>[
      TodoEditLoaded(
        todo: Todo(
          id: 1,
          name: "lorem ipsum",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: null,
          note: "lorem ipsum",
        ),
      )
    ],
  );

  blocTest<TodoEditBloc, TodoEditState>(
    'Complete date changed event',
    build: () => todoEditbloc,
    verify: (_) {
      verify(todoOverviewBloc.add(TodoOverviewFetchEvent()));
      verify(repository.update(
        Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: DateTime(DateTime.now().year, 8, 30),
          dueDate: null,
          note: "lorem ipsum",
        ),
      ));
    },
    act: (bloc) => bloc.add(
      TodoEditCompleteDateChanged(
        date: DateTime(DateTime.now().year, 8, 30),
      ),
    ),
    expect: () => <TodoEditState>[
      TodoEditLoaded(
        todo: Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: DateTime(DateTime.now().year, 8, 30),
          dueDate: null,
          note: "lorem ipsum",
        ),
      )
    ],
  );

  blocTest<TodoEditBloc, TodoEditState>(
    'Due date changed event',
    build: () => todoEditbloc,
    verify: (_) {
      verify(todoOverviewBloc.add(TodoOverviewFetchEvent()));
      verify(repository.update(
        Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: DateTime(DateTime.now().year, 8, 30),
          note: "lorem ipsum",
        ),
      ));
    },
    act: (bloc) => bloc.add(
      TodoEditDueDateChanged(
        dueDate: DateTime(DateTime.now().year, 8, 30),
      ),
    ),
    expect: () => <TodoEditState>[
      TodoEditLoaded(
        todo: Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: DateTime(DateTime.now().year, 8, 30),
          note: "lorem ipsum",
        ),
      )
    ],
  );

  blocTest<TodoEditBloc, TodoEditState>(
    'Note changed event',
    build: () => todoEditbloc,
    verify: (_) {
      verify(todoOverviewBloc.add(TodoOverviewFetchEvent()));
      verify(repository.update(
        Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: null,
          note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        ),
      ));
    },
    act: (bloc) => bloc.add(
      const TodoEditNoteChanged(
        note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
    ),
    expect: () => <TodoEditState>[
      TodoEditLoaded(
        todo: Todo(
          id: 1,
          name: "delectus aut autem",
          createdDate: DateTime(DateTime.now().year, 1, 1),
          completeDate: null,
          dueDate: null,
          note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        ),
      )
    ],
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';

import '../mock/todo_repository_mok.dart';

class MockTodoOverviewBloc
    extends MockBloc<TodoOverViewEvent, TodoOverviewState>
    implements TodoOverViewBloc {}

void main() {
  late TodoEditBloc bloc;

  final List<Todo> todos = [
    Todo(
      id: 1,
      name: "delectus aut autem",
      createdDate: DateTime(DateTime.now().year, 1, 1),
      completeDate: null,
      dueDate: null,
      note: "lorem ipsum",
    ),
    Todo(
      id: 2,
      name: "quis ut nam facilis et officia qui",
      createdDate: DateTime(DateTime.now().year, 2, 1),
      completeDate: DateTime(DateTime.now().year, 3, 15),
      dueDate: null,
    ),
  ];

  setUp(() async {
    bloc = TodoEditBloc(
      Todo(
        id: 1,
        name: "delectus aut autem",
        createdDate: DateTime(DateTime.now().year, 1, 1),
        completeDate: null,
        dueDate: null,
        note: "lorem ipsum",
      ),
      MockTodoRepository(todos: todos),
      MockTodoOverviewBloc(),
    );
  });

  blocTest<TodoEditBloc, TodoEditState>(
    'emits TodoEditLoaded when TodoEditTitleChanged is added.',
    build: () => bloc,
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
    'emits TodoEditLoaded when TodoEditCompleteDateChanged is added.',
    build: () => bloc,
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
    'emits TodoEditLoaded when TodoEditDueDateChanged is added.',
    build: () => bloc,
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
    'emits TodoEditLoaded when TodoEditNoteChanged is added.',
    build: () => bloc,
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

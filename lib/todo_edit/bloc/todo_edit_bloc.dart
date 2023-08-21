import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  Todo todo;
  final ITodoRepository repository;
  final TodoOverviewBloc bloc;

  TodoEditBloc(this.todo, this.repository, this.bloc)
      : super(TodoEditLoaded(
          todo: todo,
        )) {
    on<TodoEditTitleChanged>(_onChandedTitle);
    on<TodoEditCompleteDateChanged>(_onCompleteChanged);
    on<TodoEditDueDateChanged>(_onChandedDueDate);
    on<TodoEditNoteChanged>(_onNoteChanged);
  }

  Future<void> _onChandedTitle(TodoEditTitleChanged event, Emitter emit) async {
    update(
      todo.copyWith(
        name: event.title,
        createdDate: todo.createdDate,
        completeDate: todo.completeDate,
        dueDate: todo.dueDate,
      ),
      emit,
    );
  }

  Future<void> _onChandedDueDate(
      TodoEditDueDateChanged event, Emitter emit) async {
    update(
      todo.copyWith(
        createdDate: todo.createdDate,
        completeDate: todo.completeDate,
        dueDate: event.dueDate,
      ),
      emit,
    );
  }

  Future<void> _onCompleteChanged(
      TodoEditCompleteDateChanged event, Emitter emit) async {
    update(
        todo.copyWith(
          dueDate: todo.dueDate,
          createdDate: todo.createdDate,
          completeDate: event.date,
        ),
        emit);
  }

  Future<void> _onNoteChanged(TodoEditNoteChanged event, Emitter emit) async {
    if (todo.note == event.note) {
      return;
    }
    update(
        todo.copyWith(
          note: event.note,
          dueDate: todo.dueDate,
          createdDate: todo.createdDate,
          completeDate: todo.completeDate,
        ),
        emit);
  }

  Future<void> update(Todo newTodo, Emitter emit) async {
    try {
      repository.update(newTodo);
      // updates
      todo = newTodo;
      bloc.add(TodoOverviewFetchEvent());
      emit(TodoEditLoaded(todo: newTodo));
    } on Exception catch (error) {
      emit(TodoEditError(todo: todo, message: error.toString()));
    }
  }
}

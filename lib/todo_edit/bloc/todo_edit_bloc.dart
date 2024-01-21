import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/model/wrapped.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_overview/respository/todo_repository.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  final TodoRepository repository;

  TodoEditBloc(
    super.initialState,
    this.repository,
  ) {
    on<TodoEditTitleChanged>(_onChandedTitle);
    on<TodoEditCompleteDateChanged>(_onCompleteChanged);
    on<TodoEditDueDateChanged>(_onChandedDueDate);
    on<TodoEditDescriptionChanged>(_onDescriptionChanged);
  }

  Future<void> _onChandedTitle(TodoEditTitleChanged event, Emitter emit) async {
    await repository.save(
      state.todo.copyWith(
        name: event.title,
      ),
    );
  }

  Future<void> _onChandedDueDate(
      TodoEditDueDateChanged event, Emitter emit) async {
    await repository.save(
      state.todo.copyWith(
        dueDate: Wrapped.value(event.dueDate),
      ),
    );
  }

  Future<void> _onCompleteChanged(
      TodoEditCompleteDateChanged event, Emitter emit) async {
    await repository.save(
      state.todo.copyWith(
        completedAt: Wrapped.value(event.date),
      ),
    );
  }

  Future<void> _onDescriptionChanged(
      TodoEditDescriptionChanged event, Emitter emit) async {
    await repository.save(state.todo.copyWith(
      description: event.description,
    ));
  }
}

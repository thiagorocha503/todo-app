import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/todo_overview/respository/todo_repository.dart';

import './bloc.dart';

class TodoOverviewBloc extends Bloc<TodoOverViewEvent, TodoOverviewState> {
  final TodoRepository _repository;
  TodoOverviewBloc(
    super.initialState, {
    required TodoRepository repository,
  }) : _repository = repository {
    on<TodoOverviewSubscriptionRequested>(onSubscriptionRequested);
    on<TodoOverviewSaved>(_onSavedTodo);
    on<TodoOverviewDeleted>(_onDeleteTodos);
    on<TodoOverviewFilterChange>(_onFilterChanged);
  }

  Future<void> onSubscriptionRequested(TodoOverviewSubscriptionRequested event,
      Emitter<TodoOverviewState> emit) async {
    emit(TodoOverviewLoadingState(
      filter: state.filter,
      todos: state.todos,
    ));
    await emit.forEach(
      _repository.getTodos(),
      onData: (List<Todo> data) {
        return TodoOverviewLoadedState(
          todos: filter(
            data,
            state.filter,
          ),
          filter: state.filter,
        );
      },
    );
  }

  List<Todo> filter(List<Todo> todos, TodoFilter filter) {
    List<Todo> newList = todos;
    newList = filter.listing?.meet(newList) ?? newList;
    newList = filter.status.meet(newList);
    newList = filter.dueDate?.meet(newList) ?? newList;
    newList = filter.query?.meet(newList) ?? newList;
    return newList;
  }

  Future<void> _onFilterChanged(
      TodoOverviewFilterChange event, Emitter<TodoOverviewState> emit) async {
    emit(
      TodoOverviewLoadedState(
        todos: filter(
          _repository.getCurrentTodos(),
          event.filter,
        ),
        filter: event.filter,
      ),
    );
  }

  Future<void> _onSavedTodo(
    TodoOverviewSaved event,
    Emitter<TodoOverviewState> emit,
  ) async {
    try {
      emit(TodoOverviewLoadingState(
        filter: state.filter,
        todos: state.todos,
      ));
      await _repository.save(event.todo);
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          error: error,
          todos: state.todos,
          filter: state.filter,
        ),
      );
    }
  }

  Future<void> _onDeleteTodos(
      TodoOverviewDeleted event, Emitter<TodoOverviewState> emit) async {
    try {
      emit(TodoOverviewLoadingState(
        filter: state.filter,
        todos: state.todos,
      ));
      await _repository.delete(event.ids);
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          error: error,
          todos: state.todos,
          filter: state.filter,
        ),
      );
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/data/user_preferences.dart';
import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/todo_overview/respository/todo_repository.dart';
import './bloc.dart';

class TodoOverviewBloc extends Bloc<TodoOverViewEvent, TodoOverviewState> {
  final TodoRepository _repository;
  final UserPreferences _preferences;
  TodoOverviewBloc(
    super.initialState, {
    required TodoRepository repository,
    required UserPreferences preferences,
  })  : _preferences = preferences,
        _repository = repository {
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
    if (filter.listing != null) {
      todos = todos.where((todo) => todo.listId == filter.listing!.id).toList();
    }

    DateTime? filterDueDate = filter.dueDate;
    if (filterDueDate != null) {
      todos = todos.where((todo) {
        DateTime? dueDate = todo.dueDate;
        if (dueDate == null) {
          return false;
        }
        return dueDate.compareDateTo(filterDueDate) == 0;
      }).toList();
    }
    if (filter.query != null) {
      if (filter.query == "") {
        return [];
      }
      RegExp regExp = RegExp(
        "( ||\\w+)${filter.query}( ||\\w+)",
        multiLine: true,
        caseSensitive: false,
      );
      todos = todos
          .where((todo) => regExp.allMatches(todo.name).toList().isNotEmpty)
          .toList();
    }
    bool? showComplete = filter.showComplete;
    if (showComplete != null) {
      _preferences.setShowComplete(showComplete);
      if (!showComplete) {
        todos = todos.where((e) => e.completedAt == null).toList();
      }
    }
    return List.from(todos);
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

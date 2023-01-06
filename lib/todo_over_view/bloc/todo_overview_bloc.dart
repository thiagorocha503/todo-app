import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';

@GenerateNiceMocks([MockSpec<TodoOverviewBloc>()])
class TodoOverviewBloc extends Bloc<TodoOverViewEvent, TodoOverviewState> {
  final ITodoRepository repository;
  List<Todo> previusTodos = [];
  Filter filter;
  TodoOverviewBloc({
    required this.filter,
    required this.repository,
  }) : super(const TodoOverviewLoadingState(todos: [])) {
    on<TodoOverviewFetchEvent>(_mapGetTodos);
    on<TodoOverviewAdded>(_mapAddTodos);
    on<TodoOverviewDeleted>(_mapDeleteTodos);
    on<TodoOverviewUpdate>(_mapUpdateTodo);
    on<TodoOverviewFilterChange>(_mapFilterChanged);
  }

  Future<void> _mapFilterChanged(
      TodoOverviewFilterChange event, Emitter<TodoOverviewState> emit) async {
    try {
      previusTodos = await repository.fetch(filter: event.filter);
      // update filter
      filter = event.filter;
      emit(TodoOverviewLoadedState(todos: previusTodos));
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          message: error.toString()..replaceAll("Exception: ", ""),
          todos: previusTodos,
        ),
      );
    }
  }

  Future<void> _mapUpdateTodo(
      TodoOverviewUpdate event, Emitter<TodoOverviewState> emit) async {
    try {
      repository.update(event.todo);
      previusTodos = await repository.fetch(filter: filter);
      emit(TodoOverviewLoadedState(todos: previusTodos));
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          message: error.toString()..replaceAll("Exception: ", ""),
          todos: previusTodos,
        ),
      );
    }
  }

  Future<void> _mapGetTodos(
      TodoOverviewFetchEvent event, Emitter<TodoOverviewState> emit) async {
    try {
      emit(TodoOverviewLoadingState(todos: previusTodos));
      previusTodos = await repository.fetch(filter: filter);
      emit(TodoOverviewLoadedState(todos: previusTodos));
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          message: error.toString()..replaceAll("Exception: ", ""),
          todos: previusTodos,
        ),
      );
    }
  }

  Future<void> _mapAddTodos(
    TodoOverviewAdded event,
    Emitter<TodoOverviewState> emit,
  ) async {
    try {
      emit(TodoOverviewLoadingState(todos: previusTodos));
      repository.insert(event.todo);
      previusTodos = await repository.fetch(filter: filter);
      emit(TodoOverviewLoadedState(todos: previusTodos));
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          message: error.toString().replaceAll("Exception: ", ""),
          todos: previusTodos,
        ),
      );
    }
  }

  Future<void> _mapDeleteTodos(
      TodoOverviewDeleted event, Emitter<TodoOverviewState> emit) async {
    try {
      emit(TodoOverviewLoadingState(todos: previusTodos));
      repository.delete(event.id);
      previusTodos = await repository.fetch(filter: filter);
      emit(TodoOverviewLoadedState(todos: previusTodos));
    } on Exception catch (error) {
      emit(
        TodoOverviewErrorState(
          message: error.toString().replaceAll("Exception: ", ""),
          todos: previusTodos,
        ),
      );
    }
  }
}

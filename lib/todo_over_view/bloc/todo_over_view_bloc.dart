import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/repository.dart';

@GenerateNiceMocks([MockSpec<TodoOverViewBloc>()])
class TodoOverViewBloc extends Bloc<TodoOverViewEvent, TodoOverviewState> {
  final ITodoRepository repository;
  Filter filter;
  TodoOverViewBloc({
    required this.filter,
    required this.repository,
  }) : super(TodoOverViewLoadingState()) {
    on<TodoOverViewFetchEvent>(_mapGetTodos);
    on<TodoOverViewAdded>(_mapAddTodos);
    on<TodoOverViewDeleted>(_mapDeleteTodos);
    on<TodoOverViewUpdate>(_mapUpdateTodo);
    on<TodoOverFilterChange>(_mapFilterChanged);
  }

  Future<void> _mapFilterChanged(
      TodoOverFilterChange event, Emitter<TodoOverviewState> emit) async {
    try {
      List<Todo> todos = await repository.fetch(filter: event.filter);
      // update filter
      filter = event.filter;
      emit(TodoOverViewLoadedState(todos: todos));
    } on Exception catch (error) {
      emit(TodoOverViewErrorState(message: error.toString()));
    }
  }

  Future<void> _mapUpdateTodo(
      TodoOverViewUpdate event, Emitter<TodoOverviewState> emit) async {
    try {
      repository.update(event.todo);
      List<Todo> todos = await repository.fetch(filter: filter);
      emit(TodoOverViewLoadedState(todos: todos));
    } on Exception catch (error) {
      emit(TodoOverViewErrorState(message: error.toString()));
    }
  }

  Future<void> _mapGetTodos(
      TodoOverViewFetchEvent event, Emitter<TodoOverviewState> emit) async {
    try {
      emit(TodoOverViewLoadingState());
      List<Todo> todos = await repository.fetch(filter: filter);
      emit(TodoOverViewLoadedState(todos: todos));
    } on Exception catch (error) {
      emit(TodoOverViewErrorState(message: error.toString()));
    }
  }

  Future<void> _mapAddTodos(
    TodoOverViewAdded event,
    Emitter<TodoOverviewState> emit,
  ) async {
    try {
      emit(TodoOverViewLoadingState());
      repository.insert(event.todo);
      emit(TodoOverViewLoadedState(
          todos: await repository.fetch(filter: filter)));
    } on Exception catch (error) {
      emit(TodoOverViewErrorState(message: error.toString()));
    }
  }

  Future<void> _mapDeleteTodos(
      TodoOverViewDeleted event, Emitter<TodoOverviewState> emit) async {
    try {
      emit(TodoOverViewLoadingState());
      repository.delete(event.id);
      emit(TodoOverViewLoadedState(
          todos: await repository.fetch(filter: filter)));
    } on Exception catch (error) {
      emit(TodoOverViewErrorState(message: error.toString()));
    }
  }
}

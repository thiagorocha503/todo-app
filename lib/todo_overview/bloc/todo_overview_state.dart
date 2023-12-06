import 'package:equatable/equatable.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/model/todo.dart';

abstract class TodoOverviewState extends Equatable {
  final List<Todo> todos;
  final TodoFilter filter;
  const TodoOverviewState({
    required this.todos,
    required this.filter,
  });

  @override
  List<Object?> get props => [todos, filter];
}

class TodoOverviewLoadingState extends TodoOverviewState {
  const TodoOverviewLoadingState({
    required super.todos,
    required super.filter,
  });
}

class TodoOverviewLoadedState extends TodoOverviewState {
  const TodoOverviewLoadedState({
    required super.todos,
    required super.filter,
  });
}

class TodoOverviewErrorState extends TodoOverviewState {
  final Exception error;

  const TodoOverviewErrorState({
    required this.error,
    required super.todos,
    required super.filter,
  });

  @override
  List<Object?> get props => [error, super.todos, super.filter];
}

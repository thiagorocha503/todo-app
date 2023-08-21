import 'package:equatable/equatable.dart';
import 'package:todo/todo_over_view/model/todo.dart';

abstract class TodoOverviewState extends Equatable {
  final List<Todo> todos;
  const TodoOverviewState({required this.todos});
}

class TodoOverviewLoadingState extends TodoOverviewState {
  const TodoOverviewLoadingState({required super.todos});
  @override
  List<Object?> get props => [super.todos];
}

class TodoOverviewLoadedState extends TodoOverviewState {
  const TodoOverviewLoadedState({required super.todos});

  @override
  List<Object?> get props => [super.todos];
}

class TodoOverviewErrorState extends TodoOverviewState {
  final String message;

  const TodoOverviewErrorState({required this.message, required super.todos});

  @override
  List<Object?> get props => [message, super.todos];
}

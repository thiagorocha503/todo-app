import 'package:equatable/equatable.dart';
import 'package:todo/todo_over_view/model/todo.dart';

abstract class TodoOverviewState extends Equatable {}

class TodoOverViewLoadingState extends TodoOverviewState {
  @override
  List<Object?> get props => [];
}

class TodoOverViewLoadedState extends TodoOverviewState {
  final List<Todo> todos;
  TodoOverViewLoadedState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodoOverViewErrorState extends TodoOverviewState {
  final String message;

  TodoOverViewErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

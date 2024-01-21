import 'package:equatable/equatable.dart';
import 'package:todo/todo_overview/model/todo.dart';

abstract class TodoEditState extends Equatable {
  final Todo todo;
  const TodoEditState({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class TodoEditLoaded extends TodoEditState {
  const TodoEditLoaded({required super.todo});

  @override
  List<Object> get props => [super.todo];
}

class TodoEditError extends TodoEditState {
  final String message;
  const TodoEditError({required super.todo, required this.message});

  @override
  List<Object> get props => [super.todo, message];
}

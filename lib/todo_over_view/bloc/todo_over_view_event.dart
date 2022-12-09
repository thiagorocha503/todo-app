import 'package:equatable/equatable.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';

abstract class TodoOverViewEvent extends Equatable {}

class TodoOverViewFetchEvent extends TodoOverViewEvent {
  @override
  List<Object?> get props => [];
}

class TodoOverViewAdded extends TodoOverViewEvent {
  final Todo todo;

  TodoOverViewAdded({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class TodoOverViewDeleted extends TodoOverViewEvent {
  final int id;

  TodoOverViewDeleted({required this.id});
  @override
  List<Object?> get props => [id];
}

class TodoOverViewUpdate extends TodoOverViewEvent {
  final Todo todo;

  TodoOverViewUpdate({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoOverFilterChange extends TodoOverViewEvent {
  final Filter filter;

  TodoOverFilterChange({required this.filter});

  @override
  List<Object?> get props => [filter];
}

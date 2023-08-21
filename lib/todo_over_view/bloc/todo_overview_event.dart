import 'package:equatable/equatable.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/todo_over_view/model/todo.dart';

abstract class TodoOverViewEvent extends Equatable {}

class TodoOverviewFetchEvent extends TodoOverViewEvent {
  @override
  List<Object?> get props => [];
}

class TodoOverviewAdded extends TodoOverViewEvent {
  final Todo todo;

  TodoOverviewAdded({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class TodoOverviewDeleted extends TodoOverViewEvent {
  final int id;

  TodoOverviewDeleted({required this.id});
  @override
  List<Object?> get props => [id];
}

class TodoOverviewUpdate extends TodoOverViewEvent {
  final Todo todo;

  TodoOverviewUpdate({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoOverviewFilterChange extends TodoOverViewEvent {
  final Filter filter;

  TodoOverviewFilterChange({required this.filter});

  @override
  List<Object?> get props => [filter];
}

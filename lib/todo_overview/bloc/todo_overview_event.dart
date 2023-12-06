import 'package:equatable/equatable.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/model/todo.dart';

abstract class TodoOverViewEvent extends Equatable {}

class TodoOverviewSaved extends TodoOverViewEvent {
  final Todo todo;

  TodoOverviewSaved({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class TodoOverviewDeleted extends TodoOverViewEvent {
  final List<int> ids;

  TodoOverviewDeleted({required this.ids});
  @override
  List<Object?> get props => [ids];
}

class TodoOverviewSubscriptionRequested extends TodoOverViewEvent {
  @override
  List<Object?> get props => [];
}

class TodoOverviewFilterChange extends TodoOverViewEvent {
  final TodoFilter filter;

  TodoOverviewFilterChange({required this.filter});

  @override
  List<Object?> get props => [filter];
}

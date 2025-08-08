import 'package:equatable/equatable.dart';
import 'package:todo/todo_overview/model/filter/criteria.dart';
import 'package:todo/todo_overview/model/todo.dart';

abstract class TodoCriteria extends Equatable implements Criteria<Todo> {
  @override
  bool matches(Todo todos);
}

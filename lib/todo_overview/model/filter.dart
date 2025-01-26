import 'package:equatable/equatable.dart';
import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/todo_overview/model/todo.dart';

enum TodosStatus { all, activeOnly, completedOnly }

abstract class TodoCriteria extends Equatable {
  List<Todo> meet(List<Todo> todos);
}

class TodoStatusCriteria extends TodoCriteria {
  final TodosStatus status;

  TodoStatusCriteria({required this.status});

  @override
  List<Todo> meet(List<Todo> todos) {
    return todos
        .where((e) => switch (status) {
              TodosStatus.all => true,
              TodosStatus.activeOnly => e.completedAt == null,
              TodosStatus.completedOnly => e.completedAt != null,
            })
        .toList();
  }

  @override
  List<Object?> get props => [status];
}

class TodoQueryCriteria extends TodoCriteria {
  final String query;

  TodoQueryCriteria({required this.query});

  @override
  List<Todo> meet(List<Todo> todos) {
    RegExp regExp = RegExp(
      "( ||\\w+)$query( ||\\w+)",
      multiLine: true,
      caseSensitive: false,
    );
    return todos
        .where((todo) => regExp.allMatches(todo.name).toList().isNotEmpty)
        .toList();
  }

  @override
  List<Object?> get props => [query];
}

class TodoListingCriteria extends TodoCriteria {
  final int? id;

  TodoListingCriteria({required this.id});

  @override
  List<Todo> meet(List<Todo> todos) {
    return todos.where((e) => e.listId == id).toList();
  }

  @override
  List<Object?> get props => [id];
}

class TodoDueDateCriteria extends TodoCriteria {
  final DateTime dueDate;
  TodoDueDateCriteria({
    required this.dueDate,
  });
  @override
  List<Todo> meet(List<Todo> todos) {
    return todos.where((e) {
      DateTime? date = e.dueDate;
      if (date == null) {
        return date == dueDate;
      }
      return date.compareDateTo(dueDate) == 0;
    }).toList();
  }

  @override
  List<Object?> get props => [dueDate.toIso8601String()];
}

class TodoFilter extends Equatable {
  final TodoQueryCriteria? query;
  final TodoDueDateCriteria? dueDate;
  final TodoListingCriteria? listing;
  final TodoStatusCriteria status;

  const TodoFilter(
      {this.query, this.dueDate, this.listing, required this.status});
  TodoFilter copyWith(
      {TodoDueDateCriteria? dueDate,
      TodoStatusCriteria? status,
      TodoListingCriteria? listing,
      TodoQueryCriteria? query}) {
    return TodoFilter(
      query: query ?? this.query,
      dueDate: dueDate ?? this.dueDate,
      listing: listing ?? this.listing,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        query,
        dueDate,
        listing,
        status,
      ];

  @override
  String toString() {
    return "{query: $query,  due_date:$dueDate, showComplete: $status, listing: $listing}";
  }
}

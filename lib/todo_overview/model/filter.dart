import 'package:equatable/equatable.dart';
import 'package:todo/todo_overview/model/filter/filter.dart';
import 'package:todo/todo_overview/model/filter/todo_due_date_criteria.dart';

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

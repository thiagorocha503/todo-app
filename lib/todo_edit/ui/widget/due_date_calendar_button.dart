import 'package:flutter/material.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/datetime_extension.dart';

class DueDateCalendarButton extends StatelessWidget {
  final Todo todo;
  final Function onTap;
  const DueDateCalendarButton(
      {required this.todo, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    Color? color;
    DateTime today = DateTime.now();
    DateTime? dueDate = todo.dueDate;
    if (dueDate != null) {
      if (dueDate.compareDateTo(today) >= 0) {
        color = Theme.of(context).colorScheme.primary;
      } else {
        color = Theme.of(context).colorScheme.error;
      }
    }
    return Icon(
      Icons.calendar_today,
      color: color,
    );
  }
}

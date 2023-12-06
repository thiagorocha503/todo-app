import 'package:flutter/material.dart';
import 'package:todo/shared/extension/datetime_extension.dart';

class DueDateCalendarButton extends StatelessWidget {
  final DateTime? dueDate;
  final DateTime? completeDate;
  final Function() onTap;
  const DueDateCalendarButton(
      {super.key,
      required this.dueDate,
      required this.onTap,
      required this.completeDate});

  @override
  Widget build(BuildContext context) {
    Color? color;
    DateTime today = DateTime.now();
    DateTime? date = dueDate;

    if (date != null) {
      if (completeDate != null) {
        color = Theme.of(context).colorScheme.primary;
      } else {
        if (date.compareDateTo(today) >= 0) {
          color = Theme.of(context).colorScheme.primary;
        } else {
          color = Theme.of(context).colorScheme.error;
        }
      }
    }
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.calendar_month,
        color: color,
      ),
    );
  }
}

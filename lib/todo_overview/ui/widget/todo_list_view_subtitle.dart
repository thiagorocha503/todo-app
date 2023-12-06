import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/date_formatter.dart';
import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoListTileSubtitle extends StatelessWidget {
  final Todo todo;
  const TodoListTileSubtitle({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    DateTime? dueDate = todo.dueDate?.toLocal();
    DateTime today = DateTime.now();
    if (dueDate == null) {
      return const Text("");
    }
    Color? color = Theme.of(context).colorScheme.primary;
    if (todo.completedAt == null) {
      if (dueDate.compareDateTo(today) < 0) {
        color = Theme.of(context).colorScheme.error;
      }
    }
    String text = DateFormatter(
            AppLocalizations.of(context), Localizations.localeOf(context))
        .getVerboseDateRepresentation(dueDate, context);
    return Row(
      children: [
        Icon(
          Icons.calendar_month,
          color: color,
          size: 16,
        ),
        Text(
          text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/constants/keys.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/date_formatter.dart';
import 'package:todo/util/string_extension.dart';
import 'package:todo/util/datetime_extension.dart';

class TodoOverviewListTile extends StatelessWidget {
  final Todo todo;
  final Function(bool value) onToggleCompleted;
  final Function onDelete;
  final Function onTap;
  const TodoOverviewListTile({
    required this.todo,
    super.key,
    required this.onTap,
    required this.onToggleCompleted,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: RoundCheckBox(
          key: Key("$TODO_CHECKBOX-${todo.id}"),
          size: 26,
          border: Border.all(
            color: todo.completeDate == null
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          isChecked: todo.completeDate == null ? false : true,
          checkedColor: Theme.of(context).colorScheme.primary,
          disabledColor: Colors.grey,
          uncheckedColor: Colors.transparent,
          onTap: (bool? value) {
            if (value == null) {
              return;
            }
            onToggleCompleted(value);
          },
        ),
        title: Text(
          todo.name,
          style: TextStyle(
            fontStyle:
                todo.completeDate == null ? FontStyle.normal : FontStyle.italic,
            decoration: todo.completeDate == null
                ? TextDecoration.none
                : TextDecoration.lineThrough,
          ),
        ),
        subtitle: _buildSubtitle(todo, context),
        trailing: IconButton(
          key: Key("$TODO_DELETE_ICON_BUTTON-${todo.id}"),
          tooltip:
              AppLocalizations.of(context).translate("delete").capitalize(),
          icon: const Icon(Icons.delete),
          onPressed: () {
            onDelete();
          },
        ),
        onTap: () => onTap(),
      ),
    );
  }

  Widget? _buildSubtitle(Todo todo, BuildContext context) {
    DateTime? dueDate = todo.dueDate;
    DateTime today = DateTime.now();
    if (dueDate == null) {
      return null;
    }
    Color? color = Theme.of(context).colorScheme.primary;
    if (todo.completeDate == null) {
      if (dueDate.compareDateTo(today) < 0) {
        color = Theme.of(context).colorScheme.error;
      }
    }
    String text = DateFormatter(AppLocalizations.of(context))
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

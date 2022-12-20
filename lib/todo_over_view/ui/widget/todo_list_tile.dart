import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_over_view/model/todo.dart';
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
          size: 26,
          border: Border.all(
            color: _getCheckboxBorderColor(context, todo),
            width: 2,
          ),
          animationDuration: const Duration(milliseconds: 300),
          isChecked: todo.completeDate == null ? false : true,
          checkedColor: Theme.of(context).primaryColor,
          disabledColor: Colors.grey,
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
            color: _getTextColor(context, todo),
          ),
        ),
        trailing: IconButton(
          tooltip:
              AppLocalizations.of(context).translate("delete").capitalize(),
          icon: const Icon(
            Icons.delete,
            color: Colors.blue,
          ),
          onPressed: () {
            onDelete();
          },
        ),
        onTap: () => onTap(),
      ),
    );
  }

  Color _getCheckboxBorderColor(BuildContext context, Todo todo) {
    DateTime now = DateTime.now();
    DateTime? completeDate = todo.completeDate;
    DateTime? dueDate = todo.dueDate;
    if (completeDate != null) {
      return Colors.blue;
    }
    if (dueDate != null) {
      if (dueDate.compareDateTo(now) == -1) {
        return Colors.red;
      }
    }
    return Colors.grey;
  }

  Color _getTextColor(BuildContext context, Todo todo) {
    DateTime now = DateTime.now();
    DateTime? completeDate = todo.completeDate;
    DateTime? dueDate = todo.dueDate;
    if (completeDate != null) {
      return Colors.grey;
    }
    if (dueDate != null) {
      if (dueDate.compareDateTo(now) == -1) {
        return Colors.red;
      }
    }
    return Colors.black;
  }
}

import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/todo_over_view/model/todo.dart';

class TodoOverviewListTile extends StatelessWidget {
  final Todo todo;
  final Function(bool value) onToggleCompleted;
  final Function onDelete;
  final Function onTap;
  const TodoOverviewListTile(
      {required this.todo,
      super.key,
      required this.onTap,
      required this.onToggleCompleted,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: RoundCheckBox(
          size: 26,
          border: Border.all(
            color: _getTodoColorState(context, todo) ??
                Theme.of(context).primaryColor,
            width: 2,
          ),
          animationDuration: const Duration(milliseconds: 400),
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
            color: _getTodoColorState(context, todo),
          ),
        ),
        trailing: IconButton(
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

  Color? _getTodoColorState(BuildContext context, Todo todo) {
    DateTime now = DateTime.now();
    DateTime? completeDate = todo.completeDate;
    DateTime? dueDate = todo.dueDate;
    if (completeDate != null) {
      return Theme.of(context).primaryColor;
    }
    if (dueDate != null) {
      if (dueDate.compareTo(now) > 0) {
        return Colors.red;
      }
    }
    return null; // default style
  }
}

import 'package:flutter/material.dart';
import 'package:todo/todo_over_view/model/todo.dart';

class TodoListTile extends StatelessWidget {
  final Todo todo;
  final Function(bool value) onToggleCompleted;
  final Function onDelete;
  final Function onTap;
  const TodoListTile(
      {required this.todo,
      super.key,
      required this.onTap,
      required this.onToggleCompleted,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.completeDate == null ? false : true,
          onChanged: (bool? value) {
            if (value == null) {
              return;
            }
            onToggleCompleted(value);
          },
        ),
        title: Text(todo.name),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.blue,
          ),
          onPressed: () {
            onDelete();
          },
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

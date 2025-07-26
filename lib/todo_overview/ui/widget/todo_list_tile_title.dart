import 'package:flutter/material.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoListTileTitle extends StatelessWidget {
  final Todo todo;
  const TodoListTileTitle({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Text(
      todo.name,
      style: TextStyle(
        fontStyle:
            todo.completedAt == null ? FontStyle.normal : FontStyle.italic,
        decoration: todo.completedAt == null
            ? TextDecoration.none
            : TextDecoration.lineThrough,
      ),
    );
  }
}

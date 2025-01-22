import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool checked = context.watch<TodoEditBloc>().state.todo.completedAt != null
        ? true
        : false;
    return TextFormField(
      initialValue: context.watch<TodoEditBloc>().state.todo.name,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        context.read<TodoEditBloc>().add(TodoEditTitleChanged(title: value));
      },
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        fontStyle: checked ? FontStyle.italic : FontStyle.normal,
        decoration: checked ? TextDecoration.lineThrough : TextDecoration.none,
        color: checked ? Colors.grey : null,
      ),
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).addTodo,
        border: InputBorder.none,
      ),
    );
  }
}

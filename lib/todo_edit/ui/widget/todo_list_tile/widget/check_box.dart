import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';

class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool checked = context.watch<TodoEditBloc>().state.todo.completedAt != null
        ? true
        : false;
    return RoundCheckBox(
      size: 36,
      border: Border.all(
        color: checked
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        width: 2,
      ),
      isChecked: checked,
      checkedColor: Theme.of(context).colorScheme.primary,
      disabledColor: Colors.grey,
      uncheckedColor: Colors.transparent,
      onTap: (bool? value) {
        if (value == null) {
          return;
        }
        DateTime? date;
        if (value) {
          date = DateTime.now();
        }
        context
            .read<TodoEditBloc>()
            .add(TodoEditCompleteDateChanged(date: date));
      },
    );
  }
}

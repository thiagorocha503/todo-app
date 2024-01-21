import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/shared/model/wrapped.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoCheckbox extends StatelessWidget {
  const TodoCheckbox({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return RoundCheckBox(
      size: 26,
      border: Border.all(
        color: todo.completedAt == null
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        width: 2,
      ),
      isChecked: todo.completedAt == null ? false : true,
      checkedColor: Theme.of(context).colorScheme.primary,
      disabledColor: Colors.grey,
      uncheckedColor: Colors.transparent,
      onTap: (bool? value) {
        if (value == null) {
          return;
        }
        DateTime? newDate = value ? DateTime.now().toUtc() : null;
        context.read<TodoOverviewBloc>().add(
              TodoOverviewSaved(
                todo: todo.copyWith(
                  completedAt: Wrapped<DateTime?>.value(newDate),
                ),
              ),
            );
      },
    );
  }
}

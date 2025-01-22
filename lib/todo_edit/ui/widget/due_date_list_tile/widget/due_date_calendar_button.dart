import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/due_date_list_tile.dart';

class DueDateCalendarButton extends StatelessWidget {
  final Function() onTap;

  const DueDateCalendarButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.calendar_month,
        color: _getColor(context),
      ),
    );
  }

  Color? _getColor(BuildContext context) {
    DateTime? dueDate = context.watch<DueDateCubit>().state;
    DateTime? completeDate =
        context.watch<TodoEditBloc>().state.todo.completedAt;
    if (dueDate != null) {
      if (completeDate != null) {
        return Theme.of(context).colorScheme.primary;
      } else {
        if (dueDate.compareDateTo(DateTime.now()) >= 0) {
          return Theme.of(context).colorScheme.primary;
        } else {
          return Theme.of(context).colorScheme.error;
        }
      }
    }
    return null;
  }
}

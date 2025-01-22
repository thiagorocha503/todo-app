import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/date_formatter.dart';
import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/due_date_list_tile.dart';

class DueDateText extends StatelessWidget {
  final Function() onTap;
  const DueDateText({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? dueDate = context.read<DueDateCubit>().state;
    DateTime? completeAt = context.read<TodoEditBloc>().state.todo.completedAt;
    if (dueDate == null) {
      return GestureDetector(
        onTap: onTap,
        child: Text(AppLocalizations.of(context).addDueDate),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Text(
        getText(context, dueDate),
        style: TextStyle(
          color: completeAt != null
              ? Theme.of(context).colorScheme.primary
              : isLate(dueDate.toLocal())
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
          decoration: completeAt != null
              ? TextDecoration.none
              : isLate(dueDate.toLocal())
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
        ),
      ),
    );
  }

  bool isLate(DateTime date) {
    return date.toLocal().compareDateTo(DateTime.now()) < 0;
  }

  String getText(BuildContext context, DateTime date) {
    return DateFormatter(
      AppLocalizations.of(context),
      Localizations.localeOf(context),
    ).getVerboseDateRepresentation(date, context);
  }
}

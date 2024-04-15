import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/widget/due_date_calendar_button.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/widget/due_date_clear_button.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/widget/due_date_text.dart';

class DueDateListTile extends StatefulWidget {
  final DateTime? dueDate;
  final DateTime? completeDate;
  final Function(DateTime? date) onTapped;
  const DueDateListTile({
    super.key,
    required this.dueDate,
    required this.completeDate,
    required this.onTapped,
  });

  @override
  State<DueDateListTile> createState() => _DueDateListTileState();
}

class _DueDateListTileState extends State<DueDateListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: ListTile(
        leading: DueDateCalendarButton(
          dueDate: widget.dueDate,
          onTap: onPickerDate,
          completeDate: widget.completeDate,
        ),
        title: DueDateText(
          onTap: onPickerDate,
          dueDate: widget.dueDate,
          completeDate: widget.completeDate,
        ),
        trailing: widget.dueDate != null
            ? DueDateClearIconButton(
                onPressed: onClean,
              )
            : null,
      ),
    );
  }

  void onClean() {
    widget.onTapped(null);
    context
        .read<TodoEditBloc>()
        .add(const TodoEditDueDateChanged(dueDate: null));
  }

  void onPickerDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.dueDate?.toLocal() ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 360)),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );
    if (picked != null && picked != widget.dueDate) {
      widget.onTapped(picked.toUtc());
    }
  }
}

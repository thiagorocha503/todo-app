import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_edit/ui/widget/due_date_clear_button.dart';
import 'package:todo/todo_edit/ui/widget/due_date_calendar_button.dart';
import 'package:todo/todo_edit/ui/widget/due_date_text.dart';
import 'package:todo/todo_over_view/model/todo.dart';

class DueDateListTile extends StatelessWidget {
  const DueDateListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      buildWhen: (TodoEditState previous, TodoEditState current) =>
          current.todo.dueDate != previous.todo.dueDate,
      builder: (context, state) {
        return Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: IconButton(
                onPressed: () {
                  showDueDatePicker(
                      context, BlocProvider.of(context), state.todo);
                },
                icon: DueDateCalendarButton(
                  todo: state.todo,
                  onTap: () {
                    showDueDatePicker(
                        context, BlocProvider.of(context), state.todo);
                  },
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                showDueDatePicker(
                    context, BlocProvider.of(context), state.todo);
              },
              child: DueDateText(
                dueDate: state.todo.dueDate,
              ),
            ),
            trailing: state.todo.dueDate != null
                ? const DueDateClearIconButton()
                : null,
          ),
        );
      },
    );
  }

  void showDueDatePicker(
      BuildContext context, TodoEditBloc bloc, Todo todo) async {
    DateTime? dueDate = todo.dueDate;
    DateTime selectedDate;
    if (dueDate != null) {
      selectedDate = dueDate;
    } else {
      selectedDate = DateTime.now();
    }

    DateTime firstDate = DateTime.now().subtract(const Duration(days: 30));
    DateTime lastDate = DateTime.now().add(const Duration(days: 360));
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != selectedDate) {
      bloc.add(
        TodoEditDueDateChanged(dueDate: picked),
      );
    }
  }
}

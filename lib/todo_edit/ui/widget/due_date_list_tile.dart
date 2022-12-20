import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/string_extension.dart';
import 'package:todo/util/datetime_extension.dart';

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
                icon: buildCalendarIconButton(context, state.todo),
              ),
            ),
            title: GestureDetector(
              onTap: () {
                showDueDatePicker(
                    context, BlocProvider.of(context), state.todo);
              },
              child: buildDueDateText(
                context,
                state.todo.dueDate,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                BlocProvider.of<TodoEditBloc>(context).add(
                  const TodoEditDueDateChanged(dueDate: null),
                );
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        );
      },
    );
  }

  Icon buildCalendarIconButton(BuildContext context, Todo todo) {
    Color? color;
    DateTime today = DateTime.now();
    DateTime? dueDate = todo.dueDate;
    if (dueDate != null) {
      if (dueDate.compareDateTo(today) >= 0) {
        color = Theme.of(context).primaryColor;
      } else {
        color = Colors.red;
      }
    }
    return Icon(Icons.calendar_today, color: color);
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

  Text buildDueDateText(BuildContext context, DateTime? date) {
    if (date == null) {
      return Text(
        AppLocalizations.of(context).translate("add-due-date").capitalize(),
        style: const TextStyle(color: Colors.grey),
      );
    }
    DateTime today = DateTime.now();
    DateTime localeDateTime = date.toLocal();
    String str =
        DateFormat("yMMMd", AppLocalizations.of(context).locale.languageCode)
            .format(localeDateTime);

    if (date.compareDateTo(today) < 0) {
      String text = str;
      if (date.day == today.day - 1) {
        text = AppLocalizations.of(context).translate("yesterday").capitalize();
      }
      return Text(
        text,
        style: const TextStyle(
          color: Colors.red,
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else if (date.compareDateTo(today) > 0) {
      String text = str;
      if (date.day == today.day + 1) {
        text = AppLocalizations.of(context).translate("tomorrow").capitalize();
      }
      return Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return Text(
        AppLocalizations.of(context).translate("today").capitalize(),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      );
    }
  }
}

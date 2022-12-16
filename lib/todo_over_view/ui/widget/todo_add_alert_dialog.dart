import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/string_extension.dart';

class TodoAlert extends StatefulWidget {
  const TodoAlert({
    super.key,
  });

  @override
  State<TodoAlert> createState() => _TodoAlertState();
}

class _TodoAlertState extends State<TodoAlert> {
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoOverViewBloc, TodoOverviewState>(
      listener: (context, state) {
        if (state is TodoOverViewLoadedState) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Text(
            AppLocalizations.of(context).translate("add-todo").capitalize()),
        content: TextField(
          controller: _titleController,
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context).translate("cancel").capitalize(),
            ),
          ),
          ElevatedButton(
            child: Text(
              AppLocalizations.of(context).translate("save").capitalize(),
            ),
            onPressed: () {
              if (_titleController.text.isEmpty) {
                return;
              }
              if (_titleController.text[0] == " ") {
                return;
              }
              Todo todo = Todo(
                  name: _titleController.text,
                  createdDate: DateTime.now(),
                  completeDate: null);
              BlocProvider.of<TodoOverViewBloc>(context)
                  .add(TodoOverViewAdded(todo: todo));
            },
          )
        ],
      ),
    );
  }
}

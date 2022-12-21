import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';

class DueDateClearIconButton extends StatelessWidget {
  const DueDateClearIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<TodoEditBloc>(context).add(
          const TodoEditDueDateChanged(dueDate: null),
        );
      },
      icon: const Icon(
        Icons.close,
      ),
    );
  }
}

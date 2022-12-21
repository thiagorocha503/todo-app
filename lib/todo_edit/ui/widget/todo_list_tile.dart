import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/string_extension.dart';

class TodoEditListTile extends StatelessWidget {
  const TodoEditListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const TodoCheckBox(),
        title: TodoTextField(),
      ),
    );
  }
}

class TodoCheckBox extends StatelessWidget {
  const TodoCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      buildWhen: (TodoEditState previous, TodoEditState current) {
        return previous.todo.completeDate != current.todo.completeDate;
      },
      builder: (BuildContext context, TodoEditState state) {
        return RoundCheckBox(
          key: const Key("check"),
          size: 36,
          border: Border.all(
            color: _getCheckboxBorder(context, state.todo),
            width: 2,
          ),
          isChecked: state.todo.completeDate == null ? false : true,
          checkedColor: Theme.of(context).primaryColor,
          disabledColor: Colors.grey,
          onTap: (bool? value) {
            if (value == null) {
              return;
            }
            BlocProvider.of<TodoEditBloc>(context).add(
              TodoEditCompleteDateChanged(date: value ? DateTime.now() : null),
            );
          },
        );
      },
    );
  }

  Color _getCheckboxBorder(BuildContext context, Todo todo) {
    if (todo.completeDate == null) {
      return Colors.grey;
    } else {
      return Theme.of(context).primaryColor;
    }
  }
}

class TodoTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  TodoTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      builder: (context, state) {
        controller.text = state.todo.name.replaceAll("\n", " ");
        FocusNode focusNodes = FocusNode();
        focusNodes.addListener(() {
          if (!focusNodes.hasFocus) {
            if (controller.text == "") {
              controller.text = state.todo.name;
            } else {
              context
                  .read<TodoEditBloc>()
                  .add(TodoEditTitleChanged(title: controller.text));
            }
          }
        });
        return TextField(
          focusNode: focusNodes,
          controller: controller,
          onSubmitted: (value) {
            BlocProvider.of<TodoEditBloc>(context)
                .add(TodoEditTitleChanged(title: controller.text));
          },
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            fontStyle: state.todo.completeDate == null
                ? FontStyle.normal
                : FontStyle.italic,
            decoration: state.todo.completeDate == null
                ? TextDecoration.none
                : TextDecoration.lineThrough,
            color: state.todo.completeDate == null ? null : Colors.grey,
          ),
          decoration: InputDecoration(
            hintText:
                AppLocalizations.of(context).translate("add-todo").capitalize(),
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}

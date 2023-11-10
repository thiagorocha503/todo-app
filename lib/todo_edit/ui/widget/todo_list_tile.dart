import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
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
            color: state.todo.completeDate != null
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          isChecked: state.todo.completeDate == null ? false : true,
          checkedColor: Theme.of(context).colorScheme.primary,
          disabledColor: Colors.grey,
          uncheckedColor: Colors.transparent,
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
            hintText: AppLocalizations.of(context).addTodo.capitalize(),
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}

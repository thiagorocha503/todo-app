import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/util/string_extension.dart';

class TodoEditListTile extends StatelessWidget {
  const TodoEditListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TodoCheckBox(),
      title: TodoInput(),
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
          size: 32,
          border: Border.all(
            color: Theme.of(context).primaryColor,
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
}

class TodoInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  TodoInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      builder: (context, state) {
        controller.text = state.todo.name.replaceAll("\n", " ");
        return RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              if (controller.text.isNotEmpty) {
                BlocProvider.of<TodoEditBloc>(context)
                    .add(TodoEditTitleChanged(title: controller.text));
              }
            }
          },
          child: TextField(
            controller: controller,
            onSubmitted: (value) {
              BlocProvider.of<TodoEditBloc>(context)
                  .add(TodoEditTitleChanged(title: controller.text));
            },
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontStyle: state.todo.completeDate == null
                  ? FontStyle.normal
                  : FontStyle.italic,
              decoration: state.todo.completeDate == null
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
              color: state.todo.completeDate == null ? null : Colors.grey,
            ),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)
                  .translate("add-todo")
                  .capitalize(),
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}

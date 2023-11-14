import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_edit/ui/todo_edit_page.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/ui/widget/todo_delete_alert_dialog.dart';
import 'package:todo/todo_over_view/ui/widget/todo_overview_list_tile.dart';
import 'package:todo/util/string_extension.dart';

class TodoOverviewListView extends StatelessWidget {
  const TodoOverviewListView({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).noTodo.capitalize(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        Todo todo = todos[index];
        return TodoOverviewListTile(
          todo: todos[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoEditPage(todo: todo),
              ),
            );
          },
          onToggleCompleted: (bool value) {
            context.read<TodoOverviewBloc>().add(
                  TodoOverviewUpdate(
                    todo: todo.copyWith(
                      createdDate: todo.createdDate,
                      dueDate: todo.dueDate,
                      completeDate: value ? DateTime.now() : null,
                    ),
                  ),
                );
          },
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => TodoDeleteAlertDialog(
                onConfirm: () {
                  context
                      .read<TodoOverviewBloc>()
                      .add(TodoOverviewDeleted(ids: [todo.id]));
                },
              ),
            );
          },
        );
      },
    );
  }
}

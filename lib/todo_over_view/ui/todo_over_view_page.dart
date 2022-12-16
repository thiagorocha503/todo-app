import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/filter/ui/filter_button.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_event.dart';
import 'package:todo/todo_over_view/bloc/todo_over_view_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/settings/ui/setting_page.dart';
import 'package:todo/todo_over_view/ui/widget/todo_add_alert_dialog.dart';
import 'package:todo/todo_over_view/ui/widget/todo_delete_alert_dialog.dart';
import 'package:todo/todo_over_view/ui/widget/todo_list_tile.dart';
import 'package:todo/todo_edit/ui/todo_edit_page.dart';
import 'package:todo/widget/error_dialog.dart';
import 'package:todo/util/string_extension.dart';

class TodoOverViewPage extends StatelessWidget {
  const TodoOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text(AppLocalizations.of(context).translate("todos").capitalize()),
        actions: [
          const TodoFilterButton(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: BlocConsumer<TodoOverViewBloc, TodoOverviewState>(
        listener: ((context, state) {
          if (state is TodoOverViewErrorState) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                message: state.message,
              ),
            );
          }
        }),
        builder: (BuildContext context, TodoOverviewState state) {
          if (state is TodoOverViewLoadedState) {
            List<Todo> todos = state.todos;
            if (todos.isEmpty) {
              return Center(
                child: Text(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  AppLocalizations.of(context)
                      .translate("no-todo")
                      .capitalize(),
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
                    context.read<TodoOverViewBloc>().add(
                          TodoOverViewUpdate(
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
                              .read<TodoOverViewBloc>()
                              .add(TodoOverViewDeleted(id: todo.id));
                        },
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is TodoOverViewErrorState) {
            return Center(
              child: Text(" Error: ${state.message}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) => const TodoAlert());
        },
      ),
    );
  }
}

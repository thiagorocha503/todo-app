import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/repository/todo_repository.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile.dart';
import 'package:todo/todo_edit/ui/widget/note_list_tile.dart';
import 'package:todo/widget/error_dialog.dart';
import 'package:todo/todo_edit/ui/widget/todo_footer.dart';
import 'package:todo/todo_edit/ui/widget/todo_list_tile.dart';
import 'package:todo/util/string_extension.dart';

class TodoEditPage extends StatelessWidget {
  final Todo todo;
  const TodoEditPage({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEditBloc>(
      lazy: false,
      create: (context) => TodoEditBloc(
        todo,
        TodoRepository(),
        BlocProvider.of(context),
      ),
      child: TodoEditPageView(todo: todo),
    );
  }
}

class TodoEditPageView extends StatelessWidget {
  final Todo todo;
  const TodoEditPageView({required this.todo, super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoEditBloc>(context).state;
    return BlocListener<TodoEditBloc, TodoEditState>(
      listener: (context, state) {
        if (state is TodoEditError) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              message: state.message,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppLocalizations.of(context).translate("todo").capitalize(),
          ),
          actions: const [
            SizedBox(
              width: 32,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: const [
                  TodoEditListTile(),
                  DueDateListTile(),
                  NoteListTile()
                ],
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}

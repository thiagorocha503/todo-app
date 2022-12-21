import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/app_localizations.dart';
import 'package:todo/note/note_page.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/widget/error_dialog.dart';
import 'package:todo/util/string_extension.dart';

class NoteListTile extends StatelessWidget {
  const NoteListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 100;
    return BlocConsumer<TodoEditBloc, TodoEditState>(
      listener: (context, state) => {
        if (state is TodoEditError)
          {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                message: state.message,
              ),
            )
          }
      },
      buildWhen: (previous, current) => previous.todo.note != current.todo.note,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context_) {
                  return BlocProvider<TodoEditBloc>.value(
                    value: BlocProvider.of(context),
                    child: NotePage(note: state.todo.note),
                  );
                },
              ),
            );
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 10, right: 20),
              height: height,
              width: double.infinity,
              child: Text(
                state.todo.note == ""
                    ? AppLocalizations.of(context)
                        .translate("add-note")
                        .capitalize()
                    : state.todo.note,
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/util/string_extension.dart';

class NoteSaveButton extends StatelessWidget {
  final TextEditingController controller;
  const NoteSaveButton({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    String initialNote = controller.text;
    return TextButton(
      child: Text(
        AppLocalizations.of(context).save.capitalize(),
      ),
      onPressed: () {
        if (controller.text != initialNote) {
          BlocProvider.of<TodoEditBloc>(context).add(
            TodoEditNoteChanged(note: controller.text),
          );
        }
        Navigator.pop(context);
      },
    );
  }
}

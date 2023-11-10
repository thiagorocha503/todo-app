import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/note/ui/note_save_button.dart';
import 'package:todo/note/ui/note_text_field.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/widget/toast.dart';
import 'package:todo/widget/error_dialog.dart';
import 'package:todo/util/string_extension.dart';
import 'dart:io' show Platform;

class NotePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String note;
  NotePage({required this.note, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = note;
    return BlocListener<TodoEditBloc, TodoEditState>(
      listener: (context, state) {
        if (state is TodoEditLoaded) {
          if (Platform.isAndroid || Platform.isIOS) {
            showToast(
              AppLocalizations.of(context).saved.capitalize(),
            );
          }
        }
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            AppLocalizations.of(context).note.capitalize(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: NoteSaveButton(controller: controller),
            ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Expanded(
                          child: NoteTextField(
                            controller: controller,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

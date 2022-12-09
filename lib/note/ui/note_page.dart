import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/widget/toast.dart';
import 'package:todo/widget/error_dialog.dart';
import 'package:todo/util/string_extension.dart';
import 'dart:io' show Platform;

class NotePage extends StatelessWidget {
  final TextEditingController _txtNote = TextEditingController();
  NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoEditBloc, TodoEditState>(
        listener: (context, state) {
          if (state is TodoEditLoaded) {
            Navigator.pop(context);
            if (Platform.isAndroid || Platform.isIOS) {
              showToast(
                AppLocalizations.of(context).translate("saved").capitalize(),
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
              AppLocalizations.of(context).translate("note").capitalize(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextButton(
                  child: Text(
                    AppLocalizations.of(context).translate("done").capitalize(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<TodoEditBloc>(context).add(
                      TodoEditNoteChanged(note: _txtNote.text),
                    );
                  },
                ),
              ),
            ],
          ),
          body: BlocBuilder<TodoEditBloc, TodoEditState>(
            builder: (context, state) {
              _txtNote.text = state.todo.note;
              return LayoutBuilder(
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
                              child: TextFormField(
                                autofocus: state.todo.note == "" ? true : false,
                                controller: _txtNote,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)
                                      .translate("add-note")
                                      .capitalize(),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

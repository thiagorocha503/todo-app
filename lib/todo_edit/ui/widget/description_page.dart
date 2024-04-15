import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extensions/string_extension.dart';
import 'package:todo/shared/widget/error_dialog.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';

class DescriptionPage extends StatefulWidget {
  final String initialNote;
  final Function(String value) onSave;
  const DescriptionPage(
      {required this.initialNote, super.key, required this.onSave});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late TextEditingController controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    controller = TextEditingController(text: widget.initialNote);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                onPressed: () {
                  if (controller.text != widget.initialNote &&
                      controller.text != "") {
                    widget.onSave(controller.text);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context).save.capitalize(),
                ),
              ),
            ),
          ],
        ),
        body: TextField(
          focusNode: _focusNode,
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 24.0, right: 24),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

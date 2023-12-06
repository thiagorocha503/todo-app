import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class TodoNewBottomSheet extends StatefulWidget {
  final int? listId;
  final DateTime? dueDate;
  const TodoNewBottomSheet({super.key, required this.listId, this.dueDate});

  @override
  State<TodoNewBottomSheet> createState() => _TodoNewBottomSheetState();
}

class _TodoNewBottomSheetState extends State<TodoNewBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: TextFormField(
                  focusNode: _focusNode,
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context).enterName.capitalize(),
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                          .fillOutThisFiled
                          .capitalize();
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => onSave(),
                  onChanged: (a) {
                    setState(() {});
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: _titleController.text != ""
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor,
                  ),
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void onSave() {
    if (_titleController.text != '') {
      Todo todo = Todo(
        name: _titleController.text,
        dueDate: widget.dueDate,
        listId: widget.listId,
      );
      context.read<TodoOverviewBloc>().add(TodoOverviewSaved(todo: todo));
      setState(() {
        _titleController.text = '';
      });
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

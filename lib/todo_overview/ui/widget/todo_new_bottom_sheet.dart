import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extensions/string_extension.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoNewBottomSheet extends StatefulWidget {
  final int? listId;
  final DateTime? dueDate;
  const TodoNewBottomSheet({super.key, required this.listId, this.dueDate});

  @override
  State<TodoNewBottomSheet> createState() => _TodoNewBottomSheetState();
}

class _TodoNewBottomSheetState extends State<TodoNewBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late FocusNode _focusNode;
  late DateTime? dueDate;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    dueDate = widget.dueDate;
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
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: _focusNode,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).enterName.capitalize(),
                        border: InputBorder.none,
                        hintStyle: Theme.of(context).textTheme.titleMedium,
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
                    TextField(
                      controller: _descriptionController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .description
                            .capitalize(),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  right: 16,
                  left: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(),
                    FilledButton(
                      onPressed: _nameController.text != '' ? onSave : null,
                      child: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void onSave() {
    if (_nameController.text != '') {
      Todo todo = Todo(
        name: _nameController.text,
        description: _descriptionController.text,
        dueDate: dueDate,
        listId: widget.listId,
      );
      context.read<TodoOverviewBloc>().add(TodoOverviewSaved(todo: todo));
      setState(() {
        _nameController.text = '';
        _descriptionController.text = '';
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

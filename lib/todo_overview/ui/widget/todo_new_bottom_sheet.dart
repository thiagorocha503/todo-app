import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/shared/extension/string_extension.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';

class TodoNewBottomSheet extends StatefulWidget {
  final Listing? listing;
  final DateTime? dueDate;
  const TodoNewBottomSheet({super.key, required this.listing, this.dueDate});

  @override
  State<TodoNewBottomSheet> createState() => _TodoNewBottomSheetState();
}

class _TodoNewBottomSheetState extends State<TodoNewBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late FocusNode _focusNode;
  late DateTime? _dueDate;
  late Listing? _listing;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _dueDate = widget.dueDate;
    _listing = widget.listing;
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
                  bottom: 16,
                  right: 16,
                  left: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            BlocBuilder<ListingOverviewBloc,
                                ListingOverviewState>(
                              builder: (context, state) {
                                List<Listing?> listing = [null, ...state.list];
                                return StatefulBuilder(
                                  builder: (context, setState) =>
                                      DropdownMenu<Listing?>(
                                    initialSelection: _listing,
                                    menuHeight: 200,
                                    requestFocusOnTap: false,
                                    leadingIcon: Icon(
                                      _listing?.id != null
                                          ? Icons.list
                                          : Icons.inbox,
                                    ),
                                    onSelected: (Listing? list) {
                                      setState(() => _listing = list);
                                    },
                                    dropdownMenuEntries: listing
                                        .map(
                                          (list) => DropdownMenuEntry<Listing?>(
                                            trailingIcon: Icon(
                                              list?.id == _listing?.id
                                                  ? Icons.check
                                                  : null,
                                            ),
                                            value: list,
                                            label: list?.name ??
                                                AppLocalizations.of(context)
                                                    .inboxTitle
                                                    .capitalize(),
                                            leadingIcon: Icon(
                                              list?.id == null
                                                  ? Icons.inbox
                                                  : Icons.list,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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
        dueDate: _dueDate,
        listId: _listing?.id,
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

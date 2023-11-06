import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/constants/keys.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/string_extension.dart';

class TodoBottomSheet extends StatelessWidget {
  const TodoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 80,
        // color: const Color(0xFF737373),
        child: Container(
          decoration: const BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: TodoBottomSheetContent(),
          ),
        ),
      ),
    );
  }
}

class TodoBottomSheetContent extends StatefulWidget {
  const TodoBottomSheetContent({super.key});

  @override
  State<TodoBottomSheetContent> createState() => _TodoBottomSheetContentState();
}

class _TodoBottomSheetContentState extends State<TodoBottomSheetContent> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RoundCheckBox(
        size: 24,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        checkedColor: Theme.of(context).colorScheme.primary,
        borderColor: Theme.of(context).colorScheme.primary,
        isChecked: _check,
        onTap: (bool? value) {
          if (value == null) {
            return;
          }
          _check = value;
        },
      ),
      title: Form(
        key: _formKey,
        child: TextFormField(
          key: const Key(TODO_NEW_INPUT),
          controller: _titleController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)
                .translate("enter-name")
                .capitalize(),
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)
                  .translate("fill-out-name")
                  .capitalize();
            }
            return null;
          },
          onFieldSubmitted: (_) => onSave(),
        ),
      ),
      trailing: IconButton(
        key: const Key(TODO_SAVE_ICON_BUTTON),
        icon: Icon(
          Icons.send_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: onSave,
      ),
    );
  }

  void onSave() {
    if (_formKey.currentState!.validate()) {
      Todo todo = Todo(
        name: _titleController.text,
        createdDate: DateTime.now(),
        completeDate: _check ? DateTime.now() : null,
      );
      BlocProvider.of<TodoOverviewBloc>(context)
          .add(TodoOverviewAdded(todo: todo));
      setState(() {
        _titleController.text = '';
        _check = false;
      });
    }
  }
}

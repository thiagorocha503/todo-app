import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/widget/error_dialog.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_edit/ui/widget/description_list_tile.dart';

class DescriptionPage extends StatefulWidget {
  final Function(String text) onChange;
  const DescriptionPage({super.key, required this.onChange});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final TextEditingController _descriptinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptinController.text = context.read<DescriptinCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    context.read<DescriptinCubit>().state;
    return BlocListener<TodoEditBloc, TodoEditState>(
      listener: (context, state) {
        if (state is TodoEditError) {
          debugPrint("pop");
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              message: state.message,
            ),
          );
        }
        if (state is TodoEditLoaded) {
          debugPrint("pop");
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                onPressed: () {
                  if (_descriptinController.text != "" &&
                      _descriptinController.text !=
                          context.read<TodoEditBloc>().state.todo.description) {
                    context
                        .read<DescriptinCubit>()
                        .change(_descriptinController.text);
                    widget.onChange(_descriptinController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context).save,
                ),
              ),
            ),
          ],
        ),
        body: TextFormField(
          controller: _descriptinController,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 24.0, right: 24),
          ),
        ),
      ),
    );
  }
}

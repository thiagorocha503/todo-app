import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extensions/string_extension.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/subtask/ui/subtask_add_list_tile.dart';

class SubtaskAddListTileEnabled extends StatelessWidget {
  final int todoId;
  final GlobalKey<FormState> formKey;
  const SubtaskAddListTileEnabled(
      {required this.formKey, required this.todoId, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        context.read<SubtaskInputBloc>().change(SubtaskInputAddState.disabled);
      }
    });
    return ListTile(
      leading: AbsorbPointer(
        absorbing: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RoundCheckBox(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            size: 26,
            isChecked: false,
            onTap: (bool? value) {},
          ),
        ),
      ),
      title: Form(
        key: formKey,
        child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppLocalizations.of(context).addSubtask.capitalize(),
          ),
          onFieldSubmitted: (String? value) {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).requestFocus(focusNode);
              context.read<SubtaskBloc>().add(
                    SubtaskSavedEvent(
                      subtask: Subtask(
                        complete: false,
                        name: controller.text,
                        todoId: todoId,
                      ),
                    ),
                  );

              controller.text = "";
            }
          },
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return AppLocalizations.of(context).fillOutThisFiled.capitalize();
            }
            return null;
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/model/subtask.dart';

class SubtaskItemTile extends StatefulWidget {
  final Subtask subtask;
  const SubtaskItemTile({super.key, required this.subtask});

  @override
  State<SubtaskItemTile> createState() => _SubtaskItemTileState();
}

class _SubtaskItemTileState extends State<SubtaskItemTile> {
  late TextEditingController controller;
  final FocusNode focusNodes = FocusNode();

  @override
  void initState() {
    super.initState();
    TextEditingController(text: widget.subtask.name);
    focusNodes.addListener(() {
      if (!focusNodes.hasFocus) {
        if (controller.text == "") {
          controller.text = widget.subtask.name;
        } else {
          context.read<SubtaskBloc>().add(
            SubtaskTitleChangedEvent(
              id: widget.subtask.id!,
              title: controller.text,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: RoundCheckBox(
          isChecked: widget.subtask.complete,
          size: 26,
          border: Border.all(
            color: widget.subtask.complete
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          uncheckedColor: Colors.transparent,
          checkedColor: Theme.of(context).colorScheme.primary,
          onTap: (bool? value) {
            if (value == null) {
              return;
            }
            context.read<SubtaskBloc>().add(
              SubtaskCompletionToggledEvent(
                id: widget.subtask.id,
                isCompleted: value,
              ),
            );
          },
        ),
      ),
      title: TextField(
        focusNode: focusNodes,
        controller: controller,
        style: TextStyle(
          color: widget.subtask.complete ? Colors.grey : null,
          fontStyle: widget.subtask.complete
              ? FontStyle.italic
              : FontStyle.normal,
          decoration: widget.subtask.complete
              ? TextDecoration.lineThrough
              : null,
        ),
        onSubmitted: (String? value) {
          if (value == null) {
            return;
          }
          if (value.isEmpty) {
            return;
          }
          if (widget.subtask.id == null) {
            return;
          }
          context.read<SubtaskBloc>().add(
            SubtaskTitleChangedEvent(
              id: widget.subtask.id,
              title: controller.text,
            ),
          );
        },
      ),
      trailing: IconButton(
        onPressed: () {
          context.read<SubtaskBloc>().add(
            SubtaskDeletedEvent(id: widget.subtask.id!),
          );
        },
        icon: const Icon(Icons.clear),
      ),
    );
  }
}

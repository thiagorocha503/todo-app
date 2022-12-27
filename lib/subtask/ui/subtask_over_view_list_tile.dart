import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/model/subtask.dart';

class SubtaskOverViewListTile extends StatelessWidget {
  const SubtaskOverViewListTile({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SubtaskBloc>(context).previusData;
    return BlocBuilder<SubtaskBloc, SubtaskState>(
        buildWhen: (previous, current) =>
            current is SubtasksLoadedState || current is SubtaskErrorState,
        builder: (BuildContext context, SubtaskState state) {
          return Column(
            children: List.generate(state.subtasks.length, (int index) {
              Subtask subtask = state.subtasks[index];
              TextEditingController controller =
                  TextEditingController(text: subtask.name);
              FocusNode focusNodes = FocusNode();
              focusNodes.addListener(() {
                if (!focusNodes.hasFocus) {
                  if (controller.text == "") {
                    controller.text = subtask.name;
                  } else {
                    context.read<SubtaskBloc>().add(
                          UpdateSubtaskEvent(
                            subtask: subtask.copyWith(name: controller.text),
                          ),
                        );
                  }
                }
              });
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RoundCheckBox(
                    isChecked: subtask.complete,
                    size: 26,
                    border: Border.all(
                      color: _getCheckboxBorderColor(context, subtask),
                      width: 2,
                    ),
                    uncheckedColor: Colors.transparent,
                    checkedColor: Theme.of(context).colorScheme.primary,
                    onTap: (bool? value) {
                      if (value == null) {
                        return;
                      }
                      context.read<SubtaskBloc>().add(
                            UpdateSubtaskEvent(
                              subtask: subtask.copyWith(
                                complete: value,
                              ),
                            ),
                          );
                    },
                  ),
                ),
                title: TextField(
                  focusNode: focusNodes,
                  controller: controller,
                  style: TextStyle(
                    color: subtask.complete ? Colors.grey : null,
                    fontStyle:
                        subtask.complete ? FontStyle.italic : FontStyle.normal,
                    decoration:
                        subtask.complete ? TextDecoration.lineThrough : null,
                  ),
                  onSubmitted: (String? value) {
                    if (value == null) {
                      return;
                    }
                    if (value.isEmpty) {
                      return;
                    }
                    context.read<SubtaskBloc>().add(
                          UpdateSubtaskEvent(
                            subtask: subtask.copyWith(
                              name: controller.text,
                            ),
                          ),
                        );
                  },
                ),
                trailing: IconButton(
                  onPressed: () {
                    context
                        .read<SubtaskBloc>()
                        .add(DeleteSubtaskEvent(id: state.subtasks[index].id));
                  },
                  icon: const Icon(Icons.clear),
                ),
              );
            }),
          );
        });
  }

  Color _getCheckboxBorderColor(BuildContext context, Subtask subtask) {
    if (subtask.complete) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Colors.grey;
    }
  }
}

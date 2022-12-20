import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/model/subtask.dart';
import 'package:todo/util/string_extension.dart';

enum SubtaskInputState { selected, unselected }

class SubtaskInputBloc extends Cubit<SubtaskInputState> {
  SubtaskInputBloc({required SubtaskInputState state}) : super(state);

  void change(SubtaskInputState state) {
    emit(state);
  }
}

class SubtaskInput extends StatelessWidget {
  final int todoId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SubtaskInput({required this.todoId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskInputBloc, SubtaskInputState>(
      builder: (context, SubtaskInputState state) {
        switch (state) {
          case SubtaskInputState.selected:
            {
              TextEditingController controller = TextEditingController();
              FocusNode focusNode = FocusNode();
              focusNode.addListener(() {
                if (!focusNode.hasFocus) {
                  context
                      .read<SubtaskInputBloc>()
                      .change(SubtaskInputState.unselected);
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
                      hintText: AppLocalizations.of(context)
                          .translate("add-subtask")
                          .capitalize(),
                    ),
                    onFieldSubmitted: (String? value) {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(focusNode);
                        context.read<SubtaskBloc>().add(
                              AddSubtaskEvent(
                                subtask: Subtask(
                                  id: 0,
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
                      if (value == null) {
                        return AppLocalizations.of(context)
                            .translate("fill-out-name")
                            .capitalize();
                      }
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate("fill-out-name")
                            .capitalize();
                      }
                      return null;
                    },
                  ),
                ),
              );
            }

          case SubtaskInputState.unselected:
            {
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        context
                            .read<SubtaskInputBloc>()
                            .change(SubtaskInputState.selected);
                      }),
                ),
                title: GestureDetector(
                  onTap: () {
                    context
                        .read<SubtaskInputBloc>()
                        .change(SubtaskInputState.selected);
                  },
                  child: Text(
                    AppLocalizations.of(context)
                        .translate("add-subtask")
                        .capitalize(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/subtask/ui/widget/subtask_add_list_tile_disable.dart';
import 'package:todo/subtask/ui/widget/subtask_add_list_tile_enabled.dart';

enum SubtaskInputAddState { enabled, disabled }

class SubtaskInputBloc extends Cubit<SubtaskInputAddState> {
  SubtaskInputBloc({required SubtaskInputAddState state}) : super(state);

  void change(SubtaskInputAddState state) {
    emit(state);
  }
}

class SubtaskAddListTile extends StatelessWidget {
  final int todoId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SubtaskAddListTile({required this.todoId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskInputBloc, SubtaskInputAddState>(
      builder: (context, SubtaskInputAddState state) {
        switch (state) {
          case SubtaskInputAddState.enabled:
            return SubtaskAddListTileEnabled(formKey: formKey, todoId: todoId);
          case SubtaskInputAddState.disabled:
            return const SubtaskAddListTileDisabled();
        }
      },
    );
  }
}

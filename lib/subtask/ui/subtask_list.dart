import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/ui/widget/subtask_item_tile.dart';

class SubtaskList extends StatelessWidget {
  const SubtaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskBloc, SubtaskState>(
      buildWhen: (previous, current) =>
          current is SubtaskLoadedState || current is SubtaskErrorState,
      builder: (BuildContext context, SubtaskState state) {
        return Column(
          children: state.subtasks.map((subtask) {
            return SubtaskItemTile(subtask: subtask);
          }).toList(),
        );
      },
    );
  }
}

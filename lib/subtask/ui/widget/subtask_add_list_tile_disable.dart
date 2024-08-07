import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/subtask/ui/subtask_add_list_tile.dart';

class SubtaskAddListTileDisabled extends StatelessWidget {
  const SubtaskAddListTileDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            context
                .read<SubtaskInputBloc>()
                .change(SubtaskInputAddState.enabled);
          },
        ),
      ),
      title: GestureDetector(
        onTap: () {
          context.read<SubtaskInputBloc>().change(SubtaskInputAddState.enabled);
        },
        child: Text(
          AppLocalizations.of(context).addSubtask,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

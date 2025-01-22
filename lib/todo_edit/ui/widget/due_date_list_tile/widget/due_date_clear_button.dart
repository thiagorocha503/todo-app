import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/due_date_list_tile.dart';

class DueDateClearIconButton extends StatelessWidget {
  final Function() onTap;
  const DueDateClearIconButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (context.read<DueDateCubit>().state == null) {
      return SizedBox(
        width: 48,
        height: 48,
      );
    }
    return IconButton(
      onPressed: () {
        context.read<DueDateCubit>().change(null);
        onTap();
      },
      icon: const Icon(
        Icons.close,
      ),
    );
  }
}

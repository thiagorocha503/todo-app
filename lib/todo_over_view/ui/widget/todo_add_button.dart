import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_over_view/ui/widget/todo_bottom_sheet.dart';
import 'package:todo/util/string_extension.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: AppLocalizations.of(context).translate("add-todo").capitalize(),
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const TodoBottomSheet(),
          isScrollControlled: true,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_overview/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_overview/ui/widget/todo_new_bottom_sheet.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class TodoNewFloatingButton extends StatelessWidget {
  final int? listId;
  final DateTime? dueDate;
  const TodoNewFloatingButton({Key? key, this.listId, this.dueDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      tooltip: AppLocalizations.of(context).addTodo.capitalize(),
      onPressed: () {
        TodoOverviewBloc listingBloc = context.read();
        showModalBottomSheet(
          context: context,
          builder: (context) => BlocProvider.value(
            value: listingBloc,
            child: TodoNewBottomSheet(
              listId: listId,
              dueDate: dueDate,
            ),
          ),
          useRootNavigator: true,
          isScrollControlled: true,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

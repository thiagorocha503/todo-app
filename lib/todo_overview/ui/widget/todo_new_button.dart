import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/shared/extension/string_extension.dart';
import 'package:todo/todo_overview/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_overview/ui/widget/todo_new_bottom_sheet.dart';

class TodoNewFloatingButton extends StatelessWidget {
  final Listing? listing;
  final DateTime? dueDate;
  const TodoNewFloatingButton({super.key, this.listing, this.dueDate});

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
              listing: listing,
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

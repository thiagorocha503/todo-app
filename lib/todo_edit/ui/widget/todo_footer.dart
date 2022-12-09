import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/util/date_formatter.dart';
import 'package:todo/util/string_extension.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      builder: (context, state) {
        DateTime? completeAt = state.todo.completeDate;
        DateTime? createdAt = state.todo.createdDate;
        Widget completeAtWidget;
        Widget createAtWidget;
        if (createdAt != null) {
          createAtWidget = Text(
            "${AppLocalizations.of(context).translate("created-at").capitalize()} ${DateFormatter(AppLocalizations.of(context)).getVerboseDateTimeRepresentation(createdAt)}",
          );
        } else {
          createAtWidget = const Text("");
        }
        if (completeAt != null) {
          completeAtWidget = Text(
            " 🔹${AppLocalizations.of(context).translate("completed-at").capitalize()} ${DateFormatter(AppLocalizations.of(context)).getVerboseDateTimeRepresentation(completeAt)}",
          );
        } else {
          completeAtWidget = const Text("");
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              createAtWidget,
              completeAtWidget,
            ],
          ),
        );
      },
    );
  }
}

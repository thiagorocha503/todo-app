import 'package:flutter/material.dart';
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
        String completeAtStr = "";
        String createAtStr = "";
        if (createdAt != null) {
          createAtStr =
              "${AppLocalizations.of(context).translate("created-at").capitalize()} ${DateFormatter(AppLocalizations.of(context)).getVerboseDateTimeRepresentation(createdAt)}";
        }
        if (completeAt != null) {
          completeAtStr =
              "  ${AppLocalizations.of(context).translate("completed-at").capitalize()} ${DateFormatter(AppLocalizations.of(context)).getVerboseDateTimeRepresentation(completeAt)}";
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  createAtStr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  completeAtStr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

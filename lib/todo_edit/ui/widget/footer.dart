import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/date_formatter.dart';
import 'package:todo/util/string_extension.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      builder: (context, state) {
        Todo todo = state.todo;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  todo.completeDate == null
                      ? "${AppLocalizations.of(context).createdAt.capitalize()} ${DateFormatter(s: AppLocalizations.of(context), locale: context.read<LanguageCubit>().state).getVerboseDateRepresentation(state.todo.createdDate!, context)}"
                      : "${AppLocalizations.of(context).completedAt.capitalize()} ${DateFormatter(s: AppLocalizations.of(context), locale: context.read<LanguageCubit>().state).getVerboseDateRepresentation(state.todo.completeDate!, context)}",
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

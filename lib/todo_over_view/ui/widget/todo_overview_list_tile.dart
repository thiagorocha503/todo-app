import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/constants/keys.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/select_list/bloc/selectable_list_bloc.dart';
import 'package:todo/select_list/bloc/selectable_list_event.dart';
import 'package:todo/select_list/bloc/selectable_list_state.dart';
import 'package:todo/todo_edit/ui/todo_edit_page.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/util/date_formatter.dart';
import 'package:todo/util/datetime_extension.dart';

class TodoOverviewListTile extends StatelessWidget {
  final Todo todo;
  const TodoOverviewListTile({
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: BlocBuilder<SelectableListBloc<int>, SelectableListState<int>>(
          builder: (context, state) {
            if (state.enabled) {
              return Checkbox(
                value: state.itens.firstWhere((e) => e.id == todo.id).selected,
                onChanged: (a) {
                  context
                      .read<SelectableListBloc<int>>()
                      .add(SelectableListTappedItem<int>(id: todo.id));
                },
              );
            }
            return RoundCheckBox(
              key: Key("$TODO_CHECKBOX-${todo.id}"),
              size: 26,
              border: Border.all(
                color: todo.completeDate == null
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              isChecked: todo.completeDate == null ? false : true,
              checkedColor: Theme.of(context).colorScheme.primary,
              disabledColor: Colors.grey,
              uncheckedColor: Colors.transparent,
              onTap: (bool? value) {
                if (value == null) {
                  return;
                }
                context.read<TodoOverviewBloc>().add(
                      TodoOverviewUpdate(
                        todo: todo.copyWith(
                          createdDate: todo.createdDate,
                          dueDate: todo.dueDate,
                          completeDate: value ? DateTime.now() : null,
                        ),
                      ),
                    );
              },
            );
          },
        ),
        title: Text(
          todo.name,
          style: TextStyle(
            fontStyle:
                todo.completeDate == null ? FontStyle.normal : FontStyle.italic,
            decoration: todo.completeDate == null
                ? TextDecoration.none
                : TextDecoration.lineThrough,
          ),
        ),
        subtitle: _buildSubtitle(todo, context),
        onTap: () {
          if (context.read<SelectableListBloc<int>>().state.enabled) {
            context
                .read<SelectableListBloc<int>>()
                .add(SelectableListTappedItem(id: todo.id));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoEditPage(todo: todo),
              ),
            );
          }
        },
        onLongPress: () {
          context
              .read<SelectableListBloc<int>>()
              .add(SelectableListLongPressedItem<int>(id: todo.id));
        },
      ),
    );
  }

  Widget? _buildSubtitle(Todo todo, BuildContext context) {
    DateTime? dueDate = todo.dueDate;
    DateTime today = DateTime.now();
    if (dueDate == null) {
      return null;
    }
    Color? color = Theme.of(context).colorScheme.primary;
    if (todo.completeDate == null) {
      if (dueDate.compareDateTo(today) < 0) {
        color = Theme.of(context).colorScheme.error;
      }
    }
    String text = DateFormatter(
            s: AppLocalizations.of(context),
            locale: context.read<LanguageCubit>().state)
        .getVerboseDateRepresentation(dueDate, context);
    return Row(
      children: [
        Icon(
          Icons.calendar_month,
          color: color,
          size: 16,
        ),
        Text(
          text,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}

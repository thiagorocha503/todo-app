import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/cubit/home_cubit.dart';
import 'package:todo/selectable_list/bloc/selectable_list_bloc.dart';
import 'package:todo/selectable_list/bloc/selectable_list_event.dart';
import 'package:todo/selectable_list/bloc/selectable_list_state.dart';
import 'package:todo/todo_edit/ui/todo_edit_page.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/todo_overview/ui/widget/todo_checkbox.dart';
import 'package:todo/todo_overview/ui/widget/todo_list_view_subtitle.dart';

class TodoListTileSelectable extends StatelessWidget {
  final Todo todo;
  const TodoListTileSelectable({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableListBloc, SelectableListState>(
      builder: (context, state) {
        return ListTile(
          leading: buildLeading(context, state),
          title: Text(
            todo.name,
            style: TextStyle(
              fontStyle: todo.completedAt == null
                  ? FontStyle.normal
                  : FontStyle.italic,
              decoration: todo.completedAt == null
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          subtitle: TodoListTileSubtitle(todo: todo),
          onTap: () {
            if (context.read<SelectableListBloc>().state.enabled) {
              context
                  .read<SelectableListBloc>()
                  .add(SelectableListTappedItem(id: todo.id!));
            } else {
              TodoOverviewBloc bloc = context.read();
              context.read<HomeCubit>().hideNavigation();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: bloc,
                    child: TodoEditPage(todo: todo),
                  ),
                ),
              );
            }
          },
          onLongPress: () {
            context
                .read<SelectableListBloc>()
                .add(SelectableListLongPressedItem(id: todo.id!));
            context.read<HomeCubit>().hideNavigation();
          },
        );
      },
    );
  }

  Widget buildLeading(BuildContext context, SelectableListState state) {
    if (state.enabled) {
      return Checkbox(
        value: state.itens.firstWhere((e) => e.id == todo.id).selected,
        onChanged: (a) {
          context
              .read<SelectableListBloc>()
              .add(SelectableListTappedItem(id: todo.id!));
        },
      );
    }

    return TodoCheckbox(todo: todo);
  }
}

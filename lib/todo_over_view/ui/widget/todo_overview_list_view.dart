import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/select_list/bloc/selectable_list_bloc.dart';
import 'package:todo/select_list/bloc/selectable_list_event.dart';
import 'package:todo/todo_over_view/model/todo.dart';
import 'package:todo/todo_over_view/ui/widget/todo_overview_list_tile.dart';
import 'package:todo/util/string_extension.dart';

class TodoOverviewListView extends StatelessWidget {
  const TodoOverviewListView({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).noTodo.capitalize(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        context.read<SelectableListBloc<int>>().add(
              SelectableListUpdateItens<int>(
                itens: todos.map((todo) => todo.id).toList(),
              ),
            );
        return TodoOverviewListTile(
          todo: todos[index],
        );
      },
    );
  }
}

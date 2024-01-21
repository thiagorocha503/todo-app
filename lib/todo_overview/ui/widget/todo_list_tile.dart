import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/home/cubit/home_cubit.dart';
import 'package:todo/todo_edit/ui/todo_edit_page.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/todo_overview/ui/widget/todo_checkbox.dart';
import 'package:todo/todo_overview/ui/widget/todo_list_view_subtitle.dart';

class TodoListTile extends StatefulWidget {
  final Todo todo;
  const TodoListTile({
    super.key,
    required this.todo,
  });

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TodoCheckbox(todo: widget.todo),
      title: Text(
        widget.todo.name,
        style: TextStyle(
          fontStyle: widget.todo.completedAt == null
              ? FontStyle.normal
              : FontStyle.italic,
          decoration: widget.todo.completedAt == null
              ? TextDecoration.none
              : TextDecoration.lineThrough,
        ),
      ),
      subtitle: TodoListTileSubtitle(todo: widget.todo),
      onTap: () {
        TodoOverviewBloc bloc = context.read();

        context.read<HomeCubit>().hideNavigation();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: bloc,
              child: TodoEditPage(todo: widget.todo),
            ),
          ),
        );
      },
    );
  }
}

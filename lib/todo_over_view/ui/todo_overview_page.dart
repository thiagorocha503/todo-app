import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/filter/ui/filter_button.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_state.dart';
import 'package:todo/todo_over_view/ui/widget/more_button.dart';
import 'package:todo/todo_over_view/ui/widget/todo_add_button.dart';
import 'package:todo/todo_over_view/ui/widget/todo_overview_list_view.dart';

import 'package:todo/util/string_extension.dart';
import 'package:todo/widget/error_dialog.dart';

class TodoOverviewPage extends StatelessWidget {
  const TodoOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate("todos").capitalize(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: TodoFilterButton(),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: MoreButton(),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<TodoOverviewBloc, TodoOverviewState>(
          listener: ((context, state) {
            if (state is TodoOverviewErrorState) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  message: state.message,
                ),
              );
            }
          }),
          builder: (BuildContext context, TodoOverviewState state) {
            if (state is TodoOverviewLoadedState ||
                state is TodoOverviewErrorState) {
              return TodoOverviewListView(todos: state.todos);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: const AddTodoButton(),
    );
  }
}

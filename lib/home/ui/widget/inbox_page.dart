import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extension/string_extension.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/ui/widget/todo_list_tile.dart';
import 'package:todo/todo_overview/ui/widget/todo_new_button.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoOverviewBloc>(
      create: (context) => TodoOverviewBloc(
        const TodoOverviewLoadedState(
          todos: [],
          filter: TodoFilter(listing: null),
        ),
        repository: RepositoryProvider.of(context),
        preferences: RepositoryProvider.of(context),
      )..add(TodoOverviewSubscriptionRequested()),
      child: const InboxPageView(),
    );
  }
}

class InboxPageView extends StatefulWidget {
  const InboxPageView({
    super.key,
  });

  @override
  State<InboxPageView> createState() => _InboxPageViewState();
}

class _InboxPageViewState extends State<InboxPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).inboxTitle.capitalize()),
      ),
      body: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context).noTodo.capitalize()),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              endIndent: 16,
              indent: 16,
              height: 1,
            ),
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              return TodoListTile(
                todo: state.todos[index],
              );
            },
          );
        },
      ),
      floatingActionButton: const TodoNewFloatingButton(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

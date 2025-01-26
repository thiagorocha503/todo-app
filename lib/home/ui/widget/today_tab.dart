import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/ui/widget/todo_list_tile.dart';
import 'package:todo/todo_overview/ui/widget/todo_new_button.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoOverviewBloc>(
      create: (context) => TodoOverviewBloc(
        TodoOverviewLoadedState(
          todos: const [],
          filter: TodoFilter(
              status: TodoStatusCriteria(status: TodosStatus.activeOnly),
              dueDate: TodoDueDateCriteria(dueDate: DateTime.now().toUtc())),
        ),
        repository: RepositoryProvider.of(context),
      )..add(TodoOverviewSubscriptionRequested()),
      child: const TodayPageView(),
    );
  }
}

class TodayPageView extends StatefulWidget {
  const TodayPageView({
    super.key,
  });

  @override
  State<TodayPageView> createState() => _TodayPageViewState();
}

class _TodayPageViewState extends State<TodayPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).today),
      ),
      body: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context).noTodo),
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
      floatingActionButton: TodoNewFloatingButton(
        dueDate: DateTime.now().toUtc(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/home/ui/widget/todo_search_bar.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/filter.dart';
import 'package:todo/todo_overview/model/filter/filter.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/todo_overview/ui/widget/todo_list_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoOverviewBloc>(
      create: (context) => TodoOverviewBloc(
        TodoOverviewLoadedState(
            filter: TodoFilter(
              status: TodoStatusCriteria(status: TodosStatus.all),
            ),
            todos: []),
        repository: RepositoryProvider.of(context),
      )..add(TodoOverviewSubscriptionRequested()),
      child: const SearchPageView(),
    );
  }
}

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16.0),
                child: TodoSearchBar(),
              ),
              Expanded(
                child: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
                  builder: (context, state) {
                    return ListView(
                      children: [
                        if (state.todos.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8),
                            child: Text(
                              AppLocalizations.of(context).allTodo,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        for (Todo e in state.todos)
                          TodoListTile(
                            todo: e,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

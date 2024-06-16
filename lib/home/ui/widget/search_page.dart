import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/history/bloc/bloc.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/filter.dart';
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
          const TodoOverviewLoadedState(filter: TodoFilter(), todos: []),
          repository: RepositoryProvider.of(context),
          preferences: RepositoryProvider.of(context))
        ..add(TodoOverviewSubscriptionRequested()),
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
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: SearchView());
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Semantics(
                      child: SearchBar(
                        leading: const Icon(Icons.search),
                        hintText: AppLocalizations.of(context).search,
                        shadowColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                      ),
                    ),
                  ),
                ),
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

class SearchView extends SearchDelegate {
  SearchView({String? query});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0.0,
                toolbarHeight: 72.0,
              ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return BlocBuilder<HistoricBloc, HistoryState>(
        builder: (context, state) {
          if (state.histories.isEmpty) {
            return const Divider(
              height: 1,
            );
          }
          return Column(
            children: [
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, bottom: 16, top: 16, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).recentSearches,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<HistoricBloc>().add(HistoryCleaned());
                      },
                      child: Text(
                        AppLocalizations.of(context).clear,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.histories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(state.histories[index]),
                      onTap: () {
                        query = state.histories[index];
                        showResults(context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }
    TodoOverviewBloc bloc = TodoOverviewBloc(
        const TodoOverviewLoadedState(
          filter: TodoFilter(
            query: "",
          ),
          todos: [],
        ),
        repository: RepositoryProvider.of(context),
        preferences: RepositoryProvider.of(context))
      ..add(TodoOverviewSubscriptionRequested())
      ..add(TodoOverviewFilterChange(filter: TodoFilter(query: query)));
    return BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context).noTodo),
          );
        }
        return Column(
          children: [
            const Divider(
              height: 1,
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text(query),
              onTap: () {
                showResults(context);
              },
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  Todo todo = state.todos[index];
                  return TodoListTile(
                    todo: todo,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != "") {
      context.read<HistoricBloc>().add(HistoryAdded(query: query));
    }
    TodoOverviewBloc bloc = TodoOverviewBloc(
      const TodoOverviewLoadedState(filter: TodoFilter(), todos: []),
      repository: RepositoryProvider.of(context),
      preferences: RepositoryProvider.of(context),
    )
      ..add(TodoOverviewSubscriptionRequested())
      ..add(TodoOverviewFilterChange(filter: TodoFilter(query: query)));
    return BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context).noResult,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          );
        }
        return Column(
          children: [
            const Divider(height: 1),
            ListTile(
              title: Text(
                AppLocalizations.of(context).todos,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  Todo todo = state.todos[index];
                  return BlocProvider.value(
                    value: bloc,
                    child: TodoListTile(
                      todo: todo,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

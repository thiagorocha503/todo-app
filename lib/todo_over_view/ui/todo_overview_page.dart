import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/filter/ui/filter_button.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/select_list/bloc/selectable_list_bloc.dart';
import 'package:todo/select_list/bloc/selectable_list_event.dart';
import 'package:todo/select_list/bloc/selectable_list_state.dart';
import 'package:todo/select_list/model/selectable_list_item.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_bloc.dart';
import 'package:todo/todo_over_view/bloc/todo_overview_event.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: BlocBuilder<SelectableListBloc<int>, SelectableListState<int>>(
            builder: (context, state) {
          if (state.enabled) {
            int n = 0;
            for (var element in state.itens) {
              if (element.selected) {
                n += 1;
              }
            }
            return AppBar(
              leading: IconButton(
                onPressed: () {
                  context
                      .read<SelectableListBloc<int>>()
                      .add(SelectableListCanceled());
                },
                icon: const Icon(Icons.close),
              ),
              title: Text(AppLocalizations.of(context).nSelected(n)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PopupMenuButton(
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      List<SelectableListItem<int>> result =
                          state.itens.where((e) => e.selected).toList();
                      bool isSelectedAll = result.length == state.itens.length;
                      int count = 0;
                      for (var e in state.itens) {
                        if (e.selected) {
                          count += 1;
                        }
                      }
                      return [
                        PopupMenuItem(
                          child: Text(
                            isSelectedAll
                                ? AppLocalizations.of(context)
                                    .deselectAll
                                    .capitalize()
                                : AppLocalizations.of(context)
                                    .selectAll
                                    .capitalize(),
                          ),
                          onTap: () {
                            if (isSelectedAll) {
                              context
                                  .read<SelectableListBloc<int>>()
                                  .add(SelectableListDeselectedAllItem());
                            } else {
                              context
                                  .read<SelectableListBloc<int>>()
                                  .add(SelectableListSelectedAllItem());
                            }
                          },
                        ),
                        PopupMenuItem(
                          enabled: count >= 1,
                          child: Text(
                            AppLocalizations.of(context).delete.capitalize(),
                          ),
                          onTap: () {
                            List<int> ids = [];
                            for (var item in state.itens) {
                              if (item.selected) {
                                ids.add(item.id);
                              }
                            }
                            context
                                .read<SelectableListBloc<int>>()
                                .add(SelectableListCanceled());
                            context
                                .read<TodoOverviewBloc>()
                                .add(TodoOverviewDeleted(ids: ids));
                          },
                        )
                      ];
                    },
                  ),
                )
              ],
            );
          }
          return AppBar(
            title: Text(AppLocalizations.of(context).todos.capitalize()),
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
          );
        }),
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
      floatingActionButton:
          BlocBuilder<SelectableListBloc<int>, SelectableListState<int>>(
        builder: (context, state) => Visibility(
          visible: !state.enabled,
          child: const AddTodoButton(),
        ),
      ),
    );
  }
}

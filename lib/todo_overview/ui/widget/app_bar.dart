import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/home/cubit/home_cubit.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/list_overview/ui/widget/edit_listing_dialog.dart';
import 'package:todo/list_overview/ui/widget/listing_delete_alert_dialog.dart';
import 'package:todo/selectable_list/bloc/selectable_list_bloc.dart';
import 'package:todo/selectable_list/bloc/selectable_list_event.dart';
import 'package:todo/selectable_list/bloc/selectable_list_state.dart';
import 'package:todo/shared/model/wrapped.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';

class TodoOverviewAppBar extends StatelessWidget {
  final Listing? initialList;
  const TodoOverviewAppBar({
    super.key,
    required this.initialList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableListBloc, SelectableListState>(
      builder: (context, state) {
        if (state.enabled) {
          int n = state.itens.fold(
              0,
              (previousValue, item) =>
                  item.selected ? previousValue + 1 : previousValue);
          return AppBar(
            leading: IconButton(
              onPressed: () {
                context
                    .read<SelectableListBloc>()
                    .add(SelectableListCanceled());
                context.read<HomeCubit>().showNavigation();
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
                    bool isSelectedAll = n == state.itens.length;
                    return [
                      PopupMenuItem(
                        child: Text(
                          isSelectedAll
                              ? AppLocalizations.of(context).deselectAll
                              : AppLocalizations.of(context).selectAll,
                        ),
                        onTap: () {
                          if (isSelectedAll) {
                            context
                                .read<SelectableListBloc>()
                                .add(SelectableListDeselectedAllItem());
                          } else {
                            context
                                .read<SelectableListBloc>()
                                .add(SelectableListSelectedAllItem());
                          }
                        },
                      ),
                      PopupMenuItem(
                        enabled: n > 0,
                        child: Text(
                          AppLocalizations.of(context).delete,
                        ),
                        onTap: () {
                          List<int> ids = [];
                          for (var item in state.itens) {
                            if (item.selected) {
                              ids.add(item.id);
                            }
                          }
                          context
                              .read<SelectableListBloc>()
                              .add(SelectableListCanceled());
                          context
                              .read<TodoOverviewBloc>()
                              .add(TodoOverviewDeleted(ids: ids));
                          context.read<HomeCubit>().showNavigation();
                        },
                      )
                    ];
                  },
                ),
              )
            ],
          );
        }
        return BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
          builder: (context, todoOverviewState) {
            return BlocBuilder<ListingOverviewBloc, ListingOverviewState>(
              builder: (context, listState) {
                String title;

                Listing? list = listState.list
                    .where((e) => e.id == initialList?.id)
                    .firstOrNull;
                if (list == null) {
                  title = AppLocalizations.of(context).inboxTitle;
                } else {
                  title = list.name;
                }
                return AppBar(
                  title: Text(title),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                          if (list != null) ...[
                            PopupMenuItem(
                              child: Text(
                                AppLocalizations.of(context).rename,
                              ),
                              onTap: () async {
                                context.read<HomeCubit>().hideNavigation();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditListingDialog(
                                      initialListing: list,
                                    ),
                                  ),
                                );
                                if (!context.mounted) {
                                  return;
                                }
                                context.read<HomeCubit>().showNavigation();
                              },
                            )
                          ],
                          PopupMenuItem(
                            child: Text(
                              todoOverviewState.filter.showComplete ?? false
                                  ? AppLocalizations.of(context).hidComplete
                                  : AppLocalizations.of(context).showComplete,
                            ),
                            onTap: () {
                              bool complete =
                                  todoOverviewState.filter.showComplete ??
                                      false;

                              context.read<TodoOverviewBloc>().add(
                                    TodoOverviewFilterChange(
                                      filter: context
                                          .read<TodoOverviewBloc>()
                                          .state
                                          .filter
                                          .copyWith(
                                              showComplete:
                                                  Wrapped.value(!complete)),
                                    ),
                                  );
                            },
                          ),
                          if (list != null) ...[
                            PopupMenuItem(
                              child: Text(
                                AppLocalizations.of(context).delete,
                              ),
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) =>
                                      ListingDeleteAlertDialog(
                                    name: list.name,
                                  ),
                                ).then(
                                  (value) {
                                    if (value == null) {
                                      return;
                                    }
                                    if (value) {
                                      if (!context.mounted) {
                                        return;
                                      }
                                      Navigator.pop(context);
                                      context.read<ListingOverviewBloc>().add(
                                            ListingOverviewListingDeleted(
                                              id: list.id!,
                                            ),
                                          );
                                    }
                                  },
                                );
                              },
                            )
                          ],
                        ],
                        child: const Icon(Icons.more_vert),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

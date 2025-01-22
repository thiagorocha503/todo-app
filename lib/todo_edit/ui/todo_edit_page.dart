import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/home/cubit/home_cubit.dart';
import 'package:todo/list_overview/bloc/list_overview_bloc.dart';
import 'package:todo/shared/widget/error_dialog.dart';
import 'package:todo/subtask/bloc/subtask_bloc.dart';
import 'package:todo/subtask/bloc/subtask_event.dart';
import 'package:todo/subtask/bloc/subtask_state.dart';
import 'package:todo/subtask/ui/subtask_add_list_tile.dart';
import 'package:todo/subtask/ui/subtask_over_view_list_tile.dart';
import 'package:todo/todo_edit/bloc/todo_edit_bloc.dart';
import 'package:todo/todo_edit/bloc/todo_edit_event.dart';
import 'package:todo/todo_edit/bloc/todo_edit_state.dart';
import 'package:todo/todo_edit/ui/widget/description_list_tile.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/due_date_list_tile.dart';
import 'package:todo/todo_edit/ui/widget/footer.dart';
import 'package:todo/todo_edit/ui/widget/todo_delete_alert_dialog.dart';
import 'package:todo/todo_edit/ui/widget/todo_list_tile/todo_list_tile.dart';
import 'package:todo/todo_overview/bloc/bloc.dart';
import 'package:todo/todo_overview/model/todo.dart';
import 'package:todo/todo_overview/respository/todo_repository.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}

class TodoEditPage extends StatelessWidget {
  final Todo todo;
  const TodoEditPage({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoEditBloc>(
          lazy: false,
          create: (_) => TodoEditBloc(
            TodoEditLoaded(todo: todo),
            RepositoryProvider.of<TodoRepository>(context),
          ),
        ),
        BlocProvider(
          create: (_) => SubtaskBloc(
            SubtasksLoadedState(subtasks: const [], taskId: todo.id!),
            repository: RepositoryProvider.of(context),
          )..add(SubtaskSubscriptionRequested()),
        )
      ],
      child: TodoEditPageView(todo: todo),
    );
  }
}

class TodoEditPageView extends StatefulWidget {
  final Todo todo;
  const TodoEditPageView({required this.todo, super.key});

  @override
  State<TodoEditPageView> createState() => _TodoEditPageViewState();
}

class _TodoEditPageViewState extends State<TodoEditPageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) {
            context.read<HomeCubit>().showNavigation();
          }
        },
        child: BlocListener<TodoEditBloc, TodoEditState>(
          listener: (context, state) {
            if (state is TodoEditError) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  message: state.message,
                ),
              );
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  Theme.of(context).appBarTheme.toolbarHeight ?? 56),
              child: BlocBuilder<TodoEditBloc, TodoEditState>(
                builder: (context, state) {
                  return AppBar(
                    leading: IconButton(
                      onPressed: () {
                        context.read<HomeCubit>().showNavigation();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: Text(_title(state.todo.listId)),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButton(
                          onPressed: () => _onDeletePressed(context),
                          icon: const Icon(Icons.delete),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TodoEditListTile(),
                          Card(
                            shadowColor: Colors.transparent,
                            child: Column(
                              children: [
                                const SubtaskOverViewListTile(),
                                SubtaskAddListTile(
                                  todoId: widget.todo.id!,
                                ),
                              ],
                            ),
                          ),
                          DueDateListTile(
                            initialDueDate: context
                                .watch<TodoEditBloc>()
                                .state
                                .todo
                                .dueDate,
                            onChange: (v) => context
                                .read<TodoEditBloc>()
                                .add(TodoEditDueDateChanged(dueDate: v)),
                          ),
                          DescriptionListTile(
                            initialDescription: context
                                .watch<TodoEditBloc>()
                                .state
                                .todo
                                .description,
                            onChange: (t) => context.read<TodoEditBloc>().add(
                                  TodoEditDescriptionChanged(description: t),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: RepositoryProvider.of<TodoRepository>(context)
                        .getTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Todo>? todos = snapshot.data;
                        if (todos != null) {
                          Todo? todo = todos
                              .where((e) => e.id == widget.todo.id)
                              .firstOrNull;
                          return Footer(
                            createdAt: todo?.createdAt?.toLocal(),
                            completeAt: todo?.completedAt?.toLocal(),
                          );
                        }
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _title(int? id) {
    if (id == null) {
      return AppLocalizations.of(context).inboxTitle;
    } else {
      return (context
                  .read<ListingOverviewBloc>()
                  .state
                  .list
                  .where((e) => e.id == widget.todo.listId)
                  .firstOrNull)
              ?.name ??
          AppLocalizations.of(context).inboxTitle;
    }
  }

  void _onDeletePressed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TodoDeleteAlertDialog(
        name: context.read<TodoEditBloc>().state.todo.name,
      ),
    ).then(
      (value) {
        if (value != null) {
          if (!context.mounted) {
            return;
          }
          Navigator.pop(context);
          context.read<TodoOverviewBloc>().add(
                TodoOverviewDeleted(
                  ids: [widget.todo.id ?? 0],
                ),
              );
        }
      },
    );
  }
}

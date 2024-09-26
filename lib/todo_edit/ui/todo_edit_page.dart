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
  late DateTime? completeDate;
  late DateTime? dueDate;
  late TextEditingController nameController;
  late String note;

  @override
  void initState() {
    super.initState();

    completeDate = widget.todo.completedAt;
    note = widget.todo.description;
    dueDate = widget.todo.dueDate;
    nameController =
        TextEditingController(text: widget.todo.name.replaceAll("\n", ""));
    nameController.addListener(() {
      context
          .read<TodoEditBloc>()
          .add(TodoEditTitleChanged(title: nameController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                int? id = state.todo.listId;
                String title;
                if (id == null) {
                  title = AppLocalizations.of(context).inboxTitle;
                } else {
                  title = (context
                              .read<ListingOverviewBloc>()
                              .state
                              .list
                              .where((e) => e.id == widget.todo.listId)
                              .firstOrNull)
                          ?.name ??
                      AppLocalizations.of(context).inboxTitle;
                }
                return AppBar(
                  leading: IconButton(
                    onPressed: () {
                      context.read<HomeCubit>().showNavigation();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  title: Text(title),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => TodoDeleteAlertDialog(
                              name:
                                  context.read<TodoEditBloc>().state.todo.name,
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
                                context.read<TodoOverviewBloc>().add(
                                      TodoOverviewDeleted(
                                        ids: [widget.todo.id ?? 0],
                                      ),
                                    );
                              }
                            },
                          );
                        },
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
                        TodoEditListTile(
                          check: completeDate != null,
                          controler: nameController,
                          onChange: (value) {
                            DateTime? newDate =
                                value ? DateTime.now().toUtc() : null;
                            setState(() {
                              completeDate = newDate;
                            });
                            context.read<TodoEditBloc>().add(
                                TodoEditCompleteDateChanged(date: newDate));
                          },
                        ),
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
                          completeDate: completeDate,
                          dueDate: dueDate,
                          onTapped: (dueDate) {
                            setState(() {
                              this.dueDate = dueDate;
                            });
                            if (context.mounted) {
                              context.read<TodoEditBloc>().add(
                                  TodoEditDueDateChanged(dueDate: dueDate));
                            }
                          },
                        ),
                        DescriptionListTile(
                          note: note,
                          onChange: (value) {
                            setState(() {
                              note = value;
                            });
                            context.read<TodoEditBloc>().add(
                                TodoEditDescriptionChanged(description: value));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  stream:
                      RepositoryProvider.of<TodoRepository>(context).getTodos(),
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
    );
  }
}

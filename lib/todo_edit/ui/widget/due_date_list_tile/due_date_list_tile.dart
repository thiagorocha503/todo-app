import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/widget/due_date_calendar_button.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/widget/due_date_clear_button.dart';
import 'package:todo/todo_edit/ui/widget/due_date_list_tile/widget/due_date_text.dart';

class DueDateCubit extends Cubit<DateTime?> {
  DueDateCubit(super.initialState);

  void change(DateTime? date) {
    emit(date);
  }
}

class DueDateListTile extends StatelessWidget {
  final Function(DateTime? d) onChange;
  final DateTime? initialDueDate;
  const DueDateListTile(
      {super.key, required this.onChange, required this.initialDueDate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DueDateCubit(
        initialDueDate,
      ),
      child: DueDateListTileView(
        onChange: onChange,
        initialDate: initialDueDate,
      ),
    );
  }
}

class DueDateListTileView extends StatefulWidget {
  final Function(DateTime? d) onChange;
  final DateTime? initialDate;
  const DueDateListTileView(
      {super.key, required this.onChange, required this.initialDate});

  @override
  State<DueDateListTileView> createState() => _DueDateListTileViewState();
}

class _DueDateListTileViewState extends State<DueDateListTileView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DueDateCubit, DateTime?>(
      builder: (context, state) {
        return Card(
          shadowColor: Colors.transparent,
          child: ListTile(
            leading: DueDateCalendarButton(
              onTap: () => onPickerDate(context, state),
            ),
            title: DueDateText(
              onTap: () => onPickerDate(context, state),
            ),
            trailing: DueDateClearIconButton(
              onTap: () => widget.onChange(null),
            ),
          ),
        );
      },
    );
  }

  void onPickerDate(BuildContext context, DateTime? dueDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate?.toLocal() ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 360)),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );
    if (picked != null && picked != dueDate) {
      if (!context.mounted) {
        return;
      }
      context.read<DueDateCubit>().change(picked.toUtc());
      widget.onChange(picked.toUtc());
    }
  }
}

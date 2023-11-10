import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/language/cubit/language_cubit.dart';
import 'package:todo/util/date_formatter.dart';
import 'package:todo/util/string_extension.dart';
import 'package:todo/util/datetime_extension.dart';

class DueDateText extends StatelessWidget {
  final DateTime? dueDate;
  const DueDateText({required this.dueDate, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      _getText(context, dueDate),
      style: TextStyle(
        color: _getColor(context, dueDate),
        decoration: _getDecoration(context, dueDate),
      ),
    );
  }

  TextDecoration _getDecoration(BuildContext context, DateTime? dueDate) {
    if (dueDate == null) {
      return TextDecoration.none;
    }
    if (dueDate.compareDateTo(DateTime.now()) < 0) {
      return TextDecoration.lineThrough;
    }
    return TextDecoration.none;
  }

  Color? _getColor(BuildContext context, DateTime? dueDate) {
    if (dueDate == null) {
      return Theme.of(context).textTheme.displayLarge?.color;
    }
    if (dueDate.compareDateTo(DateTime.now()) < 0) {
      return Theme.of(context).colorScheme.error;
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }

  String _getText(BuildContext context, DateTime? date) {
    if (date == null) {
      return AppLocalizations.of(context).addDueDate.capitalize();
    }
    return DateFormatter(
      s: AppLocalizations.of(context),
      locale: context.read<LanguageCubit>().state,
    ).getVerboseDateRepresentation(date, context);
  }
}

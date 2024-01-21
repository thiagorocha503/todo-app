import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/date_formatter.dart';
import 'package:todo/shared/extension/datetime_extension.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class DueDateText extends StatelessWidget {
  final DateTime? dueDate;
  final DateTime? completeDate;
  final Function() onTap;
  const DueDateText(
      {required this.dueDate,
      super.key,
      required this.onTap,
      required this.completeDate});

  @override
  Widget build(BuildContext context) {
    DateTime? date = dueDate;
    if (date == null) {
      return GestureDetector(
        onTap: onTap,
        child: Text(AppLocalizations.of(context).addDueDate.capitalize()),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Text(
        getText(context, date),
        style: TextStyle(
          color: completeDate != null
              ? Theme.of(context).colorScheme.primary
              : isLate(date.toLocal())
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
          decoration: completeDate != null
              ? TextDecoration.none
              : isLate(date.toLocal())
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
        ),
      ),
    );
  }

  bool isLate(DateTime date) {
    return date.toLocal().compareDateTo(DateTime.now()) < 0;
  }

  String getText(BuildContext context, DateTime date) {
    return DateFormatter(
      AppLocalizations.of(context),
      Localizations.localeOf(context),
    ).getVerboseDateRepresentation(date, context);
  }
}

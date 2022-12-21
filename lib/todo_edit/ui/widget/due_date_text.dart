import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_localizations.dart';
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

  Color _getColor(BuildContext context, DateTime? dueDate) {
    if (dueDate == null) {
      return Colors.grey;
    }
    if (dueDate.compareDateTo(DateTime.now()) < 0) {
      return Colors.red;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  String _getText(BuildContext context, DateTime? date) {
    if (date == null) {
      return AppLocalizations.of(context)
          .translate("add-due-date")
          .capitalize();
    }
    DateTime today = DateTime.now();
    DateTime localeDateTime = date.toLocal();

    if (date.compareDateTo(today) < 0) {
      if (date.day == today.day - 1) {
        return AppLocalizations.of(context).translate("yesterday").capitalize();
      }
    } else if (date.compareDateTo(today) > 0) {
      if (date.day == today.day + 1) {
        return AppLocalizations.of(context).translate("tomorrow").capitalize();
      }
    } else {
      return AppLocalizations.of(context).translate("today").capitalize();
    }

    return DateFormat("yMMMd", AppLocalizations.of(context).locale.languageCode)
        .format(localeDateTime);
  }
}

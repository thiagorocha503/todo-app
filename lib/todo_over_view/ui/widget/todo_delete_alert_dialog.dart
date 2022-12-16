import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/util/string_extension.dart';

class TodoDeleteAlertDialog extends StatelessWidget {
  final Function onConfirm;

  const TodoDeleteAlertDialog({required this.onConfirm, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)
            .translate("delete-alert-title")
            .capitalize(),
      ),
      content: Text(
        AppLocalizations.of(context)
            .translate("delete-alert-content")
            .capitalize(),
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context).translate("cancel").toUpperCase(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            AppLocalizations.of(context).translate("delete").toUpperCase(),
          ),
        )
      ],
    );
  }
}
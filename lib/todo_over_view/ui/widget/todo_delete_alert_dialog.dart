import 'package:flutter/material.dart';
import 'package:todo/constants/keys.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/util/string_extension.dart';

class TodoDeleteAlertDialog extends StatelessWidget {
  final Function onConfirm;

  const TodoDeleteAlertDialog({required this.onConfirm, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).deleteAlertTitle.capitalize(),
      ),
      content: Text(
        AppLocalizations.of(context).deleteAlertContent.capitalize(),
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context).cancel.capitalize(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          key: const Key(TODO_DELETE_TEXT_BUTTON),
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            AppLocalizations.of(context).delete.capitalize(),
          ),
        )
      ],
    );
  }
}

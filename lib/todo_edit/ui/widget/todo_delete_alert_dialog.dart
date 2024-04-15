import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';

class TodoDeleteAlertDialog extends StatelessWidget {
  final String name;
  const TodoDeleteAlertDialog({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).deleteTaskAlertTitle,
      ),
      content: Text(
        AppLocalizations.of(context).deleteTaskAlertBody(name),
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context).cancel,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            AppLocalizations.of(context).delete,
          ),
        )
      ],
    );
  }
}

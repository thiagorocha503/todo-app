import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extensions/string_extension.dart';

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
        AppLocalizations.of(context).deleteTaskAlertTitle.capitalize(),
      ),
      content: Text(
        AppLocalizations.of(context).deleteTaskAlertBody(name).capitalize(),
      ),
      actions: [
        TextButton(
          child: Text(
            AppLocalizations.of(context).cancel.capitalize(),
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
            AppLocalizations.of(context).delete.capitalize(),
          ),
        )
      ],
    );
  }
}

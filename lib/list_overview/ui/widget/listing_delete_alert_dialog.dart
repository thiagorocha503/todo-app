import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extension/string_extension.dart';

class ListingDeleteAlertDialog extends StatelessWidget {
  final String name;
  const ListingDeleteAlertDialog({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context).deleteListAlertTitle.capitalize(),
      ),
      content: Text(
        AppLocalizations.of(context).deleteListAlertBody(name).capitalize(),
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

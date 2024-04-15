import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';

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
        AppLocalizations.of(context).deleteListAlertTitle,
      ),
      content: Text(
        AppLocalizations.of(context).deleteListAlertBody(name),
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

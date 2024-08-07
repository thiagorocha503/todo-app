import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).error),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}

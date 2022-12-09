import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/util/string_extension.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate("error").capitalize()),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context).translate("ok").capitalize(),
          ),
        ),
      ],
    );
  }
}

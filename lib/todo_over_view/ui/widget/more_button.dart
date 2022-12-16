import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/settings/ui/setting_page.dart';
import 'package:todo/util/string_extension.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).translate("settings").capitalize(),
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
      },
    );
  }
}

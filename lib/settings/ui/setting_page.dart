import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo/constants.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/settings/ui/widgets/widgets.dart';
import 'package:todo/shared/extension/string_extension.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int groupValue = 0;
  String version = "";

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).settings.capitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const ThemeListTile(),
                  const LanguageListTile(),
                  if (Platform.isAndroid) const RateListTile(),
                  const ShareListTile(),
                  const FeedbackListTile(),
                  AboutListTile(
                    icon: const Icon(Icons.info),
                    applicationIcon: Image.asset(
                      "assets/img/todo.png",
                      height: 80,
                    ),
                    applicationName: appName.capitalize(),
                    applicationVersion: version,
                    applicationLegalese: appLegalese.capitalize(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = "v${packageInfo.version}";
    });
  }
}

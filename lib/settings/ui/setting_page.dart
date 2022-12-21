import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/constants/app_about.dart' as constants;
import 'package:todo/settings/ui/widgets/widgets.dart';

import 'package:todo/util/string_extension.dart';

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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context).translate("settings").capitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
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
                    applicationName: constants.APP_NAME.capitalize(),
                    applicationVersion: version,
                    applicationLegalese: constants.APP_LEGALESE.capitalize(),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/constants/app_about.dart';
import 'package:todo/util/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class RateListTile extends StatelessWidget {
  const RateListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shop),
      title: Text(
        AppLocalizations.of(context).translate("rate").capitalize(),
      ),
      onTap: () {
        onStore();
      },
    );
  }

  void onStore() async {
    if (Platform.isAndroid) {
      StoreRedirect.redirect(androidAppId: ANDROID_APP_ID);
      return;
    }
    String url = ANDROID_APP_LINK;
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

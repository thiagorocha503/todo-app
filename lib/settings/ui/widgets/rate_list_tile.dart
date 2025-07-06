import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:todo/constants.dart';
import 'package:todo/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class RateListTile extends StatelessWidget {
  const RateListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shop),
      title: Text(
        AppLocalizations.of(context).rate,
      ),
      onTap: () {
        onStore();
      },
    );
  }

  void onStore() async {
    if (Platform.isAndroid) {
      StoreRedirect.redirect(androidAppId: androidAppId);
      return;
    }
    String url = androidAPPLink;
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

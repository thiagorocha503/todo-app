import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/constants/app_about.dart' as constants;
import 'package:todo/util/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackListTile extends StatelessWidget {
  const FeedbackListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.feedback),
      title: Text(
        AppLocalizations.of(context).translate("feedback").capitalize(),
      ),
      onTap: () {
        onContact();
      },
    );
  }

  void onContact() async {
    Uri uri = Uri(
      scheme: "mailto",
      path: constants.CONTACT_EMAIL,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

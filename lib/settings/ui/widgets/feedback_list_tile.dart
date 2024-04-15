import 'package:flutter/material.dart';
import 'package:todo/constants.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extensions/string_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackListTile extends StatelessWidget {
  const FeedbackListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.feedback),
      title: Text(
        AppLocalizations.of(context).feedback.capitalize(),
      ),
      onTap: () {
        onContact();
      },
    );
  }

  void onContact() async {
    Uri uri = Uri(
      scheme: "mailto",
      path: contactEmail,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}

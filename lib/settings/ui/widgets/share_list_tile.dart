import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/constants/app_about.dart' as constants;
import 'package:todo/util/string_extension.dart';
import 'package:share_plus/share_plus.dart';

class ShareListTile extends StatelessWidget {
  const ShareListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.share),
      title: Text(
        AppLocalizations.of(context)
            .translate("share-with-your-friends")
            .capitalize(),
      ),
      onTap: () {
        onShare();
      },
    );
  }

  void onShare() {
    Share.share(constants.ANDROID_APP_LINK);
  }
}

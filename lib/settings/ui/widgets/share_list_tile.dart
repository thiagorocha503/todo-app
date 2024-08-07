import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo/constants.dart';
import 'package:todo/generated/l10n.dart';

class ShareListTile extends StatelessWidget {
  const ShareListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.share),
      title: Text(
        AppLocalizations.of(context).shareWithYourFriends,
      ),
      onTap: () {
        onShare();
      },
    );
  }

  void onShare() {
    Share.share(androidAPPLink);
  }
}

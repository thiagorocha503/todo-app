import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/util/string_extension.dart';
import 'package:launch_review/launch_review.dart';

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
    LaunchReview.launch();
  }
}

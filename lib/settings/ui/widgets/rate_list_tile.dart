import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:todo/generated/l10n.dart';

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
    LaunchReview.launch();
  }
}

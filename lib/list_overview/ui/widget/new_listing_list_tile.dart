import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/list_overview/ui/widget/edit_listing_dialog.dart';

class NewListingListTile extends StatelessWidget {
  const NewListingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: const Icon(Icons.add),
        title: Text(
          AppLocalizations.of(context).addList,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditListingDialog(
                initialListing: Listing(name: "", count: 0),
              ),
            ),
          );
        },
      ),
    );
  }
}

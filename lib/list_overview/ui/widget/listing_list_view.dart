import 'package:flutter/widgets.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/list_overview/ui/widget/listing_list_tile.dart';

class ListingListView extends StatelessWidget {
  final int itemCount;
  final List<Listing> listing;
  const ListingListView({
    super.key,
    required this.itemCount,
    required this.listing,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ListingListTile(
          list: listing[index],
        );
      },
    );
  }
}

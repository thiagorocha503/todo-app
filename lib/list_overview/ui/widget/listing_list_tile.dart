import 'package:flutter/material.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/todo_overview/ui/todo_overview_page.dart';

class ListingListTile extends StatefulWidget {
  final Listing list;

  const ListingListTile({
    super.key,
    required this.list,
  });

  @override
  State<ListingListTile> createState() => _ListingListTileState();
}

class _ListingListTileState extends State<ListingListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.list),
      title: Text(widget.list.name),
      trailing: widget.list.count > 0
          ? Text(
              "${widget.list.count}",
            )
          : null,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoOverviewPage(
              list: widget.list,
            ),
          ),
        );
      },
    );
  }
}

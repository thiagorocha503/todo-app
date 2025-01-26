import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/home/cubit/home_cubit.dart';
import 'package:todo/list_overview/bloc/bloc.dart';
import 'package:todo/list_overview/model/listing.dart';
import 'package:todo/list_overview/ui/widget/edit_listing_dialog.dart';
import 'package:todo/list_overview/ui/widget/listing_list_view.dart';
import 'package:todo/settings/ui/setting_page.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  bool _isExpandedList = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).browse),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () async {
                context.read<HomeCubit>().hideNavigation();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsPage(),
                  ),
                );
                if (!context.mounted) return;
                context.read<HomeCubit>().showNavigation();
              },
              icon: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: BlocBuilder<ListingOverviewBloc, ListingOverviewState>(
        builder: (context, state) {
          return ListView(
            children: [
              StatefulBuilder(
                builder: (context, setState) => Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      setState(() {
                        _isExpandedList = value;
                      });
                    },
                    initiallyExpanded: _isExpandedList,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).lists,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        IconButton(
                          onPressed: () async {
                            context.read<HomeCubit>().hideNavigation();
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EditListingDialog(
                                    initialListing: Listing(name: "", count: 0),
                                  ),
                                ));
                            if (!context.mounted) return;
                            context.read<HomeCubit>().showNavigation();
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                    children: [
                      ListingListView(
                        itemCount: state.list.length,
                        listing: state.list,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

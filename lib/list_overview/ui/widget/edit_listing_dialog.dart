import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/list_overview/bloc/list_overview_bloc.dart';
import 'package:todo/list_overview/bloc/list_overview_event.dart';
import 'package:todo/list_overview/model/listing.dart';

class EditListingDialog extends StatefulWidget {
  final Listing initialListing;
  const EditListingDialog({super.key, required this.initialListing});

  @override
  State<EditListingDialog> createState() => _EditListingDialogState();
}

class _EditListingDialogState extends State<EditListingDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameControler = TextEditingController();
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    _nameControler.text = widget.initialListing.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialListing.id == null
              ? AppLocalizations.of(context).addList
              : AppLocalizations.of(context).editList,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: TextButton(
              onPressed: onSave,
              child: Text(
                AppLocalizations.of(context).save,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nameControler,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.menu),
                    hintText: AppLocalizations.of(context).name,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return null;
                    }
                    if (value.isEmpty) {
                      return AppLocalizations.of(context).fillOutThisFiled;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<ListingOverviewBloc>().add(
            ListingOverviewListingSaved(
              listing: widget.initialListing.copyWith(
                name: _nameControler.text,
              ),
            ),
          );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/home/ui/widget/search_page.dart';

class TodoSearchBar extends StatefulWidget {
  const TodoSearchBar({super.key});

  @override
  State<TodoSearchBar> createState() => _TodoSearchBarState();
}

class _TodoSearchBarState extends State<TodoSearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.navigationBarTheme.backgroundColor ??
        ElevationOverlay.applySurfaceTint(
          theme.colorScheme.surface,
          theme.colorScheme.surfaceTint,
          3.0,
        );
    return Theme(
      data: theme.copyWith(
        searchBarTheme: SearchBarThemeData(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      ),
      child: SearchBar(
        focusNode: _focusNode,
        controller: _controller,
        autoFocus: false,
        hintText: AppLocalizations.of(context).search,
        leading: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        onTap: () {
          showSearch(context: context, delegate: SearchView());
          _focusNode.unfocus();
        },
      ),
    );
  }
}

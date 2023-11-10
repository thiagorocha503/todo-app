import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/filter/bloc/filter_bloc.dart';
import 'package:todo/filter/model/filter.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/util/string_extension.dart';

class TodoFilterButton extends StatelessWidget {
  const TodoFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: AppLocalizations.of(context).filter.capitalize(),
      icon: const Icon(Icons.filter_alt_sharp),
      itemBuilder: (context) {
        List<FilterItem> itens = [
          FilterItem(
            filter: Filter.all,
            name: AppLocalizations.of(context).all.capitalize(),
          ),
          FilterItem(
            filter: Filter.active,
            name: AppLocalizations.of(context).active.capitalize(),
          ),
          FilterItem(
            filter: Filter.done,
            name: AppLocalizations.of(context).complete.capitalize(),
          ),
        ];
        return List<PopupMenuItem>.generate(
          itens.length,
          (index) {
            return PopupMenuItem(
              child: Text(itens[index].name),
              onTap: () => context.read<FilterCubit>().change(
                    itens[index].filter,
                  ),
            );
          },
        );
      },
    );
  }
}

class FilterItem {
  final String name;
  final Filter filter;
  const FilterItem({required this.name, required this.filter});
}

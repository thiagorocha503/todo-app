import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/extension/string_extension.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/ui/theme_page.dart';

class ThemeListTileSelect extends StatelessWidget {
  final ThemeItem themeItem;
  const ThemeListTileSelect({required this.themeItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        title: Text(
          themeItem.name.capitalize(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: context.read<ThemeCubit>().state == themeItem.value
            ? Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: () {
          context.read<ThemeCubit>().changue(themeItem.value);
        },
      ),
    );
  }
}

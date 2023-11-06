import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/theme/cubit/theme_cubit.dart';
import 'package:todo/theme/ui/theme_page.dart';
import 'package:todo/util/string_extension.dart';

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
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            themeItem.name.capitalize(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.9),
            ),
          ),
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

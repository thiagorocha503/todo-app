import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TaskCheckbox extends StatelessWidget {
  final bool checked;
  final Function(bool value) onTap;

  const TaskCheckbox({super.key, required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RoundCheckBox(
      size: 36,
      border: Border.all(
        color: checked
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        width: 2,
      ),
      isChecked: checked,
      checkedColor: Theme.of(context).colorScheme.primary,
      disabledColor: Colors.grey,
      uncheckedColor: Colors.transparent,
      onTap: (bool? value) {
        if (value == null) {
          return;
        }
        onTap(value);
      },
    );
  }
}

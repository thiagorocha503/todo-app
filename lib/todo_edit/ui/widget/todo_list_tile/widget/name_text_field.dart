import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool checked;

  NameTextField({
    super.key,
    required this.controller,
    required this.checked,
    this.focusNode,
  });

  final FocusNode focusNodes = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      textInputAction: TextInputAction.done,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        fontStyle: checked ? FontStyle.italic : FontStyle.normal,
        decoration: checked ? TextDecoration.lineThrough : TextDecoration.none,
        color: checked ? Colors.grey : null,
      ),
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).addTodo.capitalize(),
        border: InputBorder.none,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo/todo_edit/ui/widget/todo_list_tile/widget/check_box.dart';
import 'package:todo/todo_edit/ui/widget/todo_list_tile/widget/name_text_field.dart';

class TodoEditListTile extends StatelessWidget {
  final bool check;
  final Function(bool value) onChange;
  final TextEditingController controler;
  final FocusNode? focusNode;
  const TodoEditListTile({
    super.key,
    required this.check,
    required this.onChange,
    required this.controler,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: ListTile(
        leading: TaskCheckbox(
          checked: check,
          onTap: onChange,
        ),
        title: NameTextField(
          controller: controler,
          checked: check,
          focusNode: focusNode,
        ),
      ),
    );
  }
}

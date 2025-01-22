import 'package:flutter/material.dart';
import 'package:todo/todo_edit/ui/widget/todo_list_tile/widget/check_box.dart';
import 'package:todo/todo_edit/ui/widget/todo_list_tile/widget/name_text_field.dart';

class TodoEditListTile extends StatelessWidget {
  const TodoEditListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: ListTile(
        leading: TaskCheckbox(),
        title: NameTextField(),
      ),
    );
  }
}

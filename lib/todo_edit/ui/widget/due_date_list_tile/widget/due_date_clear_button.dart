import 'package:flutter/material.dart';

class DueDateClearIconButton extends StatelessWidget {
  final Function() onPressed;
  const DueDateClearIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.close,
      ),
    );
  }
}

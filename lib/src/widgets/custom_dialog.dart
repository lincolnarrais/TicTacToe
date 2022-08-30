import 'package:flutter/material.dart';

import '../core/constants.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function() onPressed;

  const CustomDialog({
    required this.title,
    required this.message,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed();
          },
          child: const Text(kResetButtonLabel),
        ),
      ],
    );
  }
}

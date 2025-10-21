import 'package:flutter/material.dart';

void showAlert(
  BuildContext context, {
  String title = "Alert",
  String content = "This is an alert dialog.",
  VoidCallback? onOk,
  VoidCallback? onCancel,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            onOk?.call();
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

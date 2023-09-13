import 'package:flutter/material.dart';

enum TypeSnackBar { success, error, warming }

void showMySnackBar(
    BuildContext context, String content, TypeSnackBar typeSnackBar) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: typeSnackBar == TypeSnackBar.error
          ? Colors.red
          : TypeSnackBar == TypeSnackBar.warming
              ? Colors.yellow
              : Colors.green,
      content: Text(content)));
}

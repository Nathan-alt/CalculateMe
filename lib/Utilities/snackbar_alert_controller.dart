import 'package:flutter/material.dart';

abstract class SnackBarController {

  static SnackBar _topSnackbar(BuildContext context, String message) {
    return SnackBar(
      content: Text(message,
          style: const TextStyle(fontSize: 20)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10),
    );
  }

  static void show(BuildContext? context, String message) {
    if (context == null) { return; }
    SnackBar snackBar = _topSnackbar(context, message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
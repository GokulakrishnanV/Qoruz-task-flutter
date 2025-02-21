import 'package:flutter/material.dart';

class CustomSnackBar {
  static show(BuildContext context, {required String title, SnackBarAction? action}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.clearSnackBars();
    scaffold.showSnackBar(SnackBar(duration: const Duration(seconds: 3), content: Text(title), action: action, behavior: SnackBarBehavior.floating));
  }
}

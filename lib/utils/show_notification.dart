import 'package:flutter/material.dart';

void showNotification(BuildContext context, String? title) {
  final snackBar = SnackBar(
    content: Text("$title"),
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

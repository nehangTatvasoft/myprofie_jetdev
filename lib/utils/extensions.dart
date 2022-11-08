import 'package:flutter/material.dart';

extension AppSnackBar on BuildContext {
  showSnackBar(String? message, {bool isError = false}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 1),
    ));
  }
}

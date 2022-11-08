import 'package:flutter/material.dart';

class ProgressDialogUtil {
  static bool _isLoading = false;
  static showProgressDialog(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
                key: ValueKey("dialog"),
                child: CircularProgressIndicator(color: Colors.deepPurple));
          });
    }
  }

  static dismissProgressDialog(BuildContext context) {
    if (_isLoading) {
      Navigator.of(context).pop();
    }
    _isLoading = false;
  }
}

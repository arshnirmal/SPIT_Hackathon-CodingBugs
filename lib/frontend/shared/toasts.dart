import 'package:flutter/material.dart';

class FlutterToast {
  static void showToast(String message, BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}

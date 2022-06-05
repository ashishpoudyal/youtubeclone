import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarUtils {
  static showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        maxLines: 1,
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static void showToast({
    required String message,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    int timeInSecForIosWeb = 1,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      // toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}


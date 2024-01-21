import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/shared/extensions/string_extension.dart';

class AppToast {
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message.capitalize(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(150, 0, 0, 0),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

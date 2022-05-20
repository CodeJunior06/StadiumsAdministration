import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stadiums_administration/utils/message.dart';

class Utils {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3));

    messengerKey.currentState?.clearSnackBars();
  }

  static bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static void toast(String message) {
    if (message.isNotEmpty) {
      Color color;
      switch (message) {
        case Success.SUCCESS_REGISTER_FIRESTORE :
        case Success.SUCCESS_LOGIN:
          {
            color = Colors.green;
            break;
          }
        default:
          color = Colors.red;
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 15,
          backgroundColor: color);
    }
  }
}

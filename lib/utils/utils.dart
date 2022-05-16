import 'package:flutter/material.dart';

class Utils {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String? text){
    if(text==null)return;

    final snackBar = SnackBar(content: Text(text),backgroundColor:Colors.red,duration: const Duration(seconds: 3));

    messengerKey.currentState?.clearSnackBars();
  }
}
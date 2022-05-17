import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stadiums_administration/utils/message.dart';

class LoginModel {
  late String errorType;
  
  // ignore: body_might_complete_normally_nullable
  Future<String?> signIn(
      final String email, final String password, BuildContext context) async {
    try { 
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
         
        return Success.SUCCESS_LOGIN;
    
    } on FirebaseAuthException catch (e) {
      
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = Errors.ERROR_USERNOTFOUND;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = Errors.ERROR_PASSWORDNOTFOUND;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = Errors.ERROR_NETWORKFAILED;
            break;
          default:
            errorType = e.message.toString();
        }
        return errorType;

      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            errorType = Errors.ERROR_USERNOTFOUND;
            break;
          case 'Error 17009':
            errorType = Errors.ERROR_PASSWORDNOTFOUND;
            break;
          case 'Error 17020':
            errorType = Errors.ERROR_NETWORKFAILED;
            break;       
          default:
           errorType = e.message.toString();
        }
        return errorType;
      }
    }
  }
}



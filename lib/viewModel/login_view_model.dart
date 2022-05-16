import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stadiums_administration/model/login_model.dart';

class LoginViewModel {
  late LoginModel loginModel;
  // ignore: unused_element
  bool _validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  bool? accessLogin(String emailOrUser, String password, BuildContext context) {
    if (emailOrUser.isEmpty || password.isEmpty) {
      return false;
    } else {
      loginModel = LoginModel();
      loginModel.signIn(emailOrUser, password, context).then((value) {
        if (value != null) {
          return false;
        } else {
          return true;
        }
      });
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:stadiums_administration/domain/models/login_model.dart';
import 'package:stadiums_administration/src/view/login.dart';
import 'package:stadiums_administration/utils/message.dart';
import 'package:stadiums_administration/utils/utils.dart';

class LoginViewModel {
  late LoginModel loginModel;
  late String? rta;

  String? accessLogin(String emailOrUser, String password, BuildContext context,CollBack a) {
    if (emailOrUser.isEmpty || password.isEmpty) {
      rta=  Errors.PASSWORD_OR_EMAIL_EMPTY;
    } else {
      loginModel = LoginModel();
      loginModel.signIn(emailOrUser, password, context).then((value) => rta = value).whenComplete(() => a.responseMessage(rta) ) ;
    }
    return rta;
  }

  bool validResponse(String response) {
    if(identical(response, Success.SUCCESS_LOGIN) ){
      return true;
    }else{
      return false;
    }
  }
   dynamic validField(String? value, bool isEmail, int numMin) {
    if (value != null && value.length < numMin) {
      return "Enter minium $numMin characters";
    } else if (isEmail) {
      var response = Utils.validateEmail(value!);
      if (response) {
        return null;
      } else {
        return "Email invalid";
      }
    } else {
      return null;
    }
  }
}

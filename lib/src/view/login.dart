import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stadiums_administration/src/routes/route.dart';
import 'package:stadiums_administration/utils/utils.dart';
import 'package:stadiums_administration/viewModel/login_view_model.dart';

class LoginView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ModuleLoginState();
  
 
}

abstract class CollBack{

   responseMessage(String? rta);

}

var emailOrUserController = TextEditingController();
var passwordController = TextEditingController();
var loginViewModel = LoginViewModel();

class _ModuleLoginState extends State<LoginView> implements CollBack {
  late CollBack onchangedCallback = this;
  
  @override
  void dispose() {
    emailOrUserController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailOrUserController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset("assets/splash.png", width: 200, height: 200),
        const Text("User or Email"),
        _inputUserOrEmail(),
        const Text("Password"),
        _inputPassword(),
        _btnPageInitial(context,onchangedCallback),
        _btnPageRegister(context),
      ]),
    ));
  }
  
  @override
  responseMessage(String? rta) {
   print("RESPONSE ASYNC "+rta!);
   Utils.toast(rta);
   
  }
  
}

Widget _inputPassword() {
  return Container(
      margin: const EdgeInsets.only(
          left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
      child: TextField(
        controller: passwordController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Type in your text",
            fillColor: Colors.white70),
      ));
}

Widget _btnPageRegister(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, Routes.REGISTER);
    },
    child: const Text('Crear Cuenta',
        style: TextStyle(decoration: TextDecoration.underline)),
  );
}

Widget _btnPageInitial(BuildContext context,CollBack onchangedCallback) {
  return Container(
      margin: const EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: () {
          
          String? validResponse = loginViewModel.accessLogin(
              emailOrUserController.text.trim().toString(),
              passwordController.text.trim().toString(),
              context,onchangedCallback);

          if (validResponse != null && validResponse.isNotEmpty) {
            var response = loginViewModel.validResponse(validResponse);
            if (response) {
              Navigator.pushNamed(context, Routes.HOME);
            } 
          }
        },
        child: const Text('INGRESAR', textScaleFactor: 1.3),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
      ));
}

Widget _inputUserOrEmail() {
  return Container(
      margin: const EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
      child: TextField(
        controller: emailOrUserController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Type in your text",
            fillColor: Colors.white70),
      ));
}

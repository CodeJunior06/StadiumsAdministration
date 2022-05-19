import 'package:flutter/material.dart';
import 'package:stadiums_administration/src/routes/route.dart';
import 'package:stadiums_administration/utils/utils.dart';
import 'package:stadiums_administration/viewModel/login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleLoginState();
}

abstract class CollBack {
  responseMessage(String? rta);
}

var emailOrUserController = TextEditingController();
var passwordController = TextEditingController();
var loginViewModel = LoginViewModel();
final keyFormLogin = GlobalKey<FormState>();

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
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: keyFormLogin,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/splash.png",
                            width: 200, height: 200),
                        Column(children: [
                          Row(
                            children: const [
                              SizedBox(width: 5.0),
                              Text("User or Email",
                                  style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                          _inputUserOrEmail(),
                        ]),
                        Column(children: [
                          Row(
                            children: const [
                              SizedBox(width: 5.0),
                              Text("Password",
                                  style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                          _inputPassword(),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                          
                          _btnPageRegister(context),
                          const SizedBox(width: 5.0),
                          _btnPageInitial(context, onchangedCallback),
                        ])
                      ]),
                ))));
  }

  @override
  responseMessage(String? rta) {
    if (rta == null) return;
    Utils.toast(rta);
  }
}

Widget _inputPassword() {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Type in your text",
            fillColor: Colors.white70),
        validator: (value) {
          return loginViewModel.validField(value, false, 5);
        },
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

Widget _btnPageInitial(BuildContext context, CollBack onchangedCallback) {
  return Container(
      margin: const EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: () {
          final isValidForm = keyFormLogin.currentState!.validate();
          if (isValidForm) {
            String? validResponse = loginViewModel.accessLogin(
                emailOrUserController.text.trim().toString(),
                passwordController.text.trim().toString(),
                context,
                onchangedCallback);

            if (validResponse != null && validResponse.isNotEmpty) {
              var response = loginViewModel.validResponse(validResponse);
              if (response) {
                Navigator.popAndPushNamed(context, Routes.HOME);
              }
            }
          }
        },
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
        child: const Text('INGRESAR', textScaleFactor: 1.3),
      ));
}

Widget _inputUserOrEmail() {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: TextFormField(
          controller: emailOrUserController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Type in your text",
              fillColor: Colors.white70),
          validator: (value) {
            return loginViewModel.validField(value, true, 5);
          }));
}

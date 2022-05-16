import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stadiums_administration/viewModel/login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleLoginState();
}

late var emailOrUserController = TextEditingController();
late var passwordController = TextEditingController();
var loginViewModel = LoginViewModel();

class _ModuleLoginState extends State<LoginView> {
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
        _btnPageInitial(context),
        _btnPageRegister()
      ]),
    ));
  }
}

Widget _inputPassword() {
  return Container(
      margin: EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
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

Widget _btnPageRegister() {
  return TextButton(
    onPressed: () {},
    child: const Text('Crear Cuenta',
        style: TextStyle(decoration: TextDecoration.underline)),
  );
}

Widget _btnPageInitial(BuildContext context) {
  return Container(
      margin: EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: () {
          bool? rta = loginViewModel.accessLogin(
              emailOrUserController.text.trim().toString(),
              passwordController.text.trim().toString(),
              context);
          if (!rta!) {
            toast();
          } else {
            Navigator.popAndPushNamed(context, "/home");
          }
        },
        child: const Text('INGRESAR', textScaleFactor: 1.3),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
      ));
}

void toast() {
  Fluttertoast.showToast(
      msg: "Text Field Empty",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 15,
      backgroundColor: Colors.red);
}

Widget _inputUserOrEmail() {
  return Container(
      margin: EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
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

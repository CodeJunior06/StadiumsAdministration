import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleRegisterState();
}

late var emailController = TextEditingController();
late var passwordController = TextEditingController();
late var nameController = TextEditingController();
late var userController = TextEditingController();

class _ModuleRegisterState extends State<RegisterView> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Container(
            child: Row(children: [
              Text("CREATE ACCOUNT"),
              Text("Name"),
              _inputName(),
              Text("User"),
              _inputUser(),
              Text("Email"),
              _inputEmail(),
              Text("Password"),
              _inputPassword(),
              Text("Choose image you")
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _inputName() {
  return Container(
      margin: EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
      child: TextField(
        controller: nameController,
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

Widget _inputUser() {
  return Container(
      margin: EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
      child: TextField(
        controller: userController,
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

Widget _inputEmail() {
  return Container(
      margin: EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
      child: TextField(
        controller: emailController,
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

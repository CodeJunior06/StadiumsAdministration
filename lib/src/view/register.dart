import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';
import 'package:stadiums_administration/src/routes/route.dart';
import 'package:stadiums_administration/viewModel/register_view_model.dart';

class RegisterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModuleRegisterState();
}

var emailController = TextEditingController();
var passwordController = TextEditingController();
var nameController = TextEditingController();
var userController = TextEditingController();

class _ModuleRegisterState extends State<RegisterView> {
  File? image;
  RegisterModelView registerViewModel = RegisterModelView();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    userController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    userController = TextEditingController();
    super.initState();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageCurrent = File(image.path);
      setState(() {
        this.image = imageCurrent;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("CREATE ACCOUNT",
            style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    const Offset(0, 20),
                    const Offset(150, 20),
                    <Color>[
                      Colors.red,
                      Colors.yellow,
                    ],
                  ))),
        const SizedBox(height: 40),
        Column(children: [
          Row(
            children: const [
              SizedBox(width: 5.0),
              Text("Name:", style: TextStyle(fontSize: 17.0)),
            ],
          ),
          _inputName(),
        ]),
        Column(children: [
          Row(
            children: const [
              SizedBox(width: 5.0),
               Text("User:", style: TextStyle(fontSize: 17.0)),
            ],
          ),
          _inputUser()
        ]),
        Column(children: [
          Row(
            children: const [
              SizedBox(width: 5.0),
               Text("Email:", style: TextStyle(fontSize: 17.0)),
            ],
          ),
          _inputEmail()
        ]),
        Column(children: [
          Row(
            children: const [
              SizedBox(width: 5.0),
              Text("Password:", style: TextStyle(fontSize: 17.0)),
            ],
          ),
          _inputPassword()
        ]),
        Column(children: [
          Row(
            children: const [
              SizedBox(width: 5.0),
              Text("Choose image you:", style: TextStyle(fontSize: 17.0)),
            ],
          ),
        ]),
        const SizedBox(height: 20),
        Column(children: [
          image != null
              ? Image?.file(image!, height: 250, width: 250)
              : Image.asset("assets/person_null.jpg", width: 250, height: 250),
          IconButton(
              onPressed: () => pickImage(ImageSource.gallery),
              icon: const Icon(Icons.add_a_photo_rounded))
        ]),
       const SizedBox(height: 20),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _btnRegresar(context),
              const SizedBox(width: 10.0),
              _buttonRegisterNewUser(context)
            ])
      ]),
    )));
  }
}

Widget _btnRegresar(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, Routes.LOGIN);
    },
    child: const Text('Crear Cuenta',
        style: TextStyle(decoration: TextDecoration.underline)),
  );
}

Widget _buttonRegisterNewUser(BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: () {
          var validResponse = registerViewModel
            
        },
        child: const Text('REGISTRAR', textScaleFactor: 1.3),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
      ));
}

Widget _inputName() {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
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
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
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
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
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
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
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

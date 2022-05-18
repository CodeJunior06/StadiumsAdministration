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

late TextEditingController emailController;
late TextEditingController passwordController;
late TextEditingController nameController;
late TextEditingController userController;
final formKey = GlobalKey<FormState>();

class _ModuleRegisterState extends State<RegisterView> {
  RegisterViewModel registerViewModel = RegisterViewModel();
  final FocusNode myFocusNode = FocusNode();
  File? image;

  @override
  void setState(VoidCallback fn) {
    this.image = image;
    super.setState(fn);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    userController.dispose();
    myFocusNode.dispose();
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
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("CREATE ACCOUNT",
                            style: TextStyle(
                                fontSize: 40,
                                foreground: Paint()
                                  ..shader = ui.Gradient.linear(
                                    const Offset(0, 20),
                                    const Offset(150, 20),
                                    <Color>[
                                      Colors.white10,
                                      Colors.black,
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
                          _inputName(registerViewModel),
                        ]),
                        Column(children: [
                          Row(
                            children: const [
                              SizedBox(width: 5.0),
                              Text("User:", style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                          _inputUser(registerViewModel)
                        ]),
                        Column(children: [
                          Row(
                            children: const [
                              SizedBox(width: 5.0),
                              Text("Email:", style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                          _inputEmail(registerViewModel)
                        ]),
                        Column(children: [
                          Row(
                            children: const [
                              SizedBox(width: 5.0),
                              Text("Password:",
                                  style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                          _inputPassword(registerViewModel)
                        ]),
                        Column(children: [
                          Row(
                            children: const [
                              SizedBox(width: 5.0),
                              Text("Choose image you:",
                                  style: TextStyle(fontSize: 17.0)),
                            ],
                          ),
                        ]),
                        const SizedBox(height: 20),
                        Column(children: [
                          image != null
                              ? Image?.file(image!, height: 250, width: 250)
                              : Image.asset("assets/person_null.jpg",
                                  width: 250, height: 250),
                          IconButton(
                            onPressed: () {
                              var a = registerViewModel
                                  .pickImage(ImageSource.gallery)
                                  .then((value) {
                                image = File(value!.path);
                                registerViewModel.saveImage(value);
                              }).whenComplete(() => "");
                            },
                            icon: const Icon(Icons.add_a_photo_rounded),
                            iconSize: 20.0,
                          )
                        ]),
                        const SizedBox(height: 20),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _btnRegresar(context),
                              const SizedBox(width: 10.0),
                              _buttonRegisterNewUser(context, registerViewModel)
                            ])
                      ]),
                ))));
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

Widget _buttonRegisterNewUser(
    BuildContext context, RegisterViewModel registerModelView) {
  return Container(
      margin: const EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: () {
          final isValidForm = formKey.currentState!.validate();
          if (isValidForm) {
            List<String> fields = [
              nameController.text.toString(),
              userController.text.toString(),
              emailController.text.toString(),
              passwordController.text.toString()
            ];
            var validResponse = registerModelView.validRegisterData(fields);
          }
        },
        child: const Text('REGISTRAR', textScaleFactor: 1.3),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
      ));
}

Widget _inputName(RegisterViewModel registerViewModel) {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Name and surname please",
            fillColor: Colors.white70),
        validator: (value) {
          return registerViewModel.validField(value, false, 5);
        },
      ));
}

Widget _inputUser(RegisterViewModel registerViewModel) {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: TextFormField(
        controller: userController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: "user for the app",
            fillColor: Colors.white70),
        validator: (value) {
          return registerViewModel.validField(value, false, 5);
        },
      ));
}

Widget _inputEmail(RegisterViewModel registerViewModel) {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "email address",
            fillColor: Colors.white70),
        validator: (value) {
          return registerViewModel.validField(value, true, 5);
        },
      ));
}

Widget _inputPassword(RegisterViewModel registerViewModel) {
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
              hintText: "password",
              fillColor: Colors.white70),
          validator: (value) {
            return registerViewModel.validField(value, false, 6);
          }));
}

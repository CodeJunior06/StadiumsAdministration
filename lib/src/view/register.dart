import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:stadiums_administration/domain/iterator/callback.dart';
import 'package:stadiums_administration/src/initial_view.dart';
import 'package:stadiums_administration/src/routes/route.dart';
import 'package:stadiums_administration/src/view/login.dart';
import 'package:stadiums_administration/utils/message.dart';
import 'package:stadiums_administration/utils/utils.dart';
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
int n400 = 400;

class _ModuleRegisterState extends State<RegisterView> implements CallBack {
  RegisterViewModel registerViewModel = RegisterViewModel();
  final FocusNode myFocusNode = FocusNode();
  File? image;

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

  var imageCurrent;
  late CallBack onchangedCallback = this;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Container(
                  margin: const EdgeInsets.only(left: 50, right: 50, top: 50),
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
                              ? CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 150.0,
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/person_null.jpg'),
                                  radius: 150.0,
                                ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                registerViewModel
                                    .pickImage(ImageSource.gallery)
                                    .then((value) {
                                  imageCurrent = File(value!.path);
                                  registerViewModel.saveImage(value);
                                }).whenComplete(() => setState(() {
                                          image = imageCurrent;
                                        }));
                              });
                            },
                            icon: const Icon(Icons.add_a_photo_rounded),
                            iconSize: 30.0,
                          )
                        ]),
                        const SizedBox(height: 20),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _btnRegresar(context),
                              const SizedBox(width: 10.0),
                              _buttonRegisterNewUser(
                                  context, registerViewModel, onchangedCallback)
                            ])
                      ]),
                ))));
  }

  @override
  responseMessage(String? rta) {
    if (rta == null) return;
    switch (rta) {
      case Success.SUCCESS_REGISTER_FIRESTORE:
        //registerViewModel.signOff();
        bool isRegister = true;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InitialPageView(isRegister: isRegister)),
        );
        break;
      default:
        Utils.toast(rta);
    }
  }
}

Widget _btnRegresar(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text('YA TENGO CUENTA',
        style: TextStyle(
            color: Color.fromRGBO(0, 191, 165, 1),
            decoration: TextDecoration.underline),
        textScaleFactor: 1.2),
  );
}

Widget _buttonRegisterNewUser(BuildContext context,
    RegisterViewModel registerViewModel, CallBack onchangedCallback) {
  return Container(
      margin: const EdgeInsets.all(25),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),
        onPressed: () {
          final isValidForm = formKey.currentState!.validate();
          if (isValidForm) {
            List<String> fields = [
              nameController.text.toString(),
              userController.text.toString(),
              emailController.text.toString(),
              passwordController.text.toString()
            ];

            registerViewModel.validRegisterData(fields, onchangedCallback);
          }
        },
        style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(0, 191, 165, 1),
            elevation: 10,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
        label: const Text('REGISTRAR', textScaleFactor: 1.3),
      ));
}

Widget _inputName(RegisterViewModel registerViewModel) {
  return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_add),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[n400]),
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
            prefixIcon: const Icon(Icons.perm_contact_cal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[n400]),
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
            hintStyle: TextStyle(color: Colors.grey[n400]),
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
              prefixIcon: const Icon(Icons.password_sharp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[n400]),
              hintText: "password",
              fillColor: Colors.white70),
          validator: (value) {
            return registerViewModel.validField(value, false, 6);
          }));
}

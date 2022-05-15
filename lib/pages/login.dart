import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _createFieldText()),
        ),
      ),
    );
  }
}

List<Widget> _createFieldText() {
  return [
    Image.asset("assets/splash.png", width: 200, height: 200),
    const Text("Usuario o Correo"),
    _inputUserOrEmail(),
    const Text("Password"),
    _inputUserOrEmail(),
    _btnPageInitial(),
    _btnPageRegister()
  ];
}

Widget _btnPageRegister() {
  return TextButton(
    onPressed: () {},
    child: const Text('Crear Cuenta',
        style: TextStyle(decoration: TextDecoration.underline)),
  );
}

Widget _btnPageInitial() {
  return Container(
      margin: EdgeInsets.all(25),
      child: ElevatedButton(
        onPressed: () {
          debugPrint('ElevatedButton Clicked');
        },
        child: const Text('INGRESAR', textScaleFactor: 1.3),
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.only(
                left: 40.0, right: 40.0, top: 22.0, bottom: 22.0)),
      ));
}

Widget _inputUserOrEmail() {
  return Container(
      margin: EdgeInsets.only(left: 80.0, right: 80.0, top: 5.0, bottom: 30.0),
      child: TextField(
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

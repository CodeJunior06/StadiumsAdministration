import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stadiums_administration/src/view/home.dart';
import 'package:stadiums_administration/src/view/login.dart';
import 'package:stadiums_administration/src/view/register.dart';

import '../utils/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class InitialPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: 'Material App',
        routes: <String, WidgetBuilder>{
          '/register' :((context) => RegisterView()),
          '/home': ((context) => HomePageView()),
          '/login' : ((context) => LoginView()),
        },
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("ERROR"));
            } else if (snapshot.hasData) {
              return HomePageView();
            } else {
              return LoginView();
            }
          },
        ));
  }
}

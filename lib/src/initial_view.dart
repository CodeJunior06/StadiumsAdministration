import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stadiums_administration/src/routes/app_routes.dart';
import 'package:stadiums_administration/src/view/home.dart';
import 'package:stadiums_administration/src/view/login.dart';

import '../utils/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class InitialPageView extends StatelessWidget {
  bool? isRegister;
  InitialPageView({Key? key, this.isRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isRegister != null) {
      FirebaseAuth.instance.signOut();
    }
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: 'Material App',
        routes: getAppRoutes(),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return HomeView();
            } else {
              return LoginView();
            }
          },
        ));
  }
}

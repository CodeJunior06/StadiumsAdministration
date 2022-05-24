import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stadiums_administration/src/routes/app_routes.dart';
import 'package:stadiums_administration/src/routes/route.dart';
import 'package:stadiums_administration/src/view/home.dart';
import 'package:stadiums_administration/src/view/login.dart';

import '../utils/utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class InitialPageView extends StatelessWidget {
  bool? isRegister;

  InitialPageView({this.isRegister});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        initialRoute: Routes.SPLASH,
        title: 'Material App',
        routes: getAppRoutes(),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (isRegister == true && isRegister != null) {
                isRegister = false;
                return LoginView();
              }
              return HomeView();
            } else {
              return LoginView();
            }
          },
        ));
  }
}

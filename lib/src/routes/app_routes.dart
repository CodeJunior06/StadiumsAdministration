import 'package:flutter/cupertino.dart';
import 'package:stadiums_administration/src/routes/route.dart';
import 'package:stadiums_administration/src/view/home.dart';
import 'package:stadiums_administration/src/view/login.dart';
import 'package:stadiums_administration/src/view/register.dart';
import 'package:stadiums_administration/src/view/splash.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, Widget Function(BuildContext)>{
    Routes.SPLASH: (BuildContext context) => SplashView(),
    Routes.LOGIN: (BuildContext context) => LoginView(),
    Routes.REGISTER: (BuildContext context) => RegisterView(),
    Routes.HOME: (BuildContext context) => HomeView()
  };
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stadiums_administration/src/routes/route.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // 5s over, navigate to a new page
      Navigator.restorablePushReplacementNamed(context,Routes.LOGIN);
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [logoAnimation(), byAuthor()],
    )));
  }
}

Widget byAuthor() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: const [
      Text(
        "Santiago Rueda - Mobile Developer",
        style: TextStyle(
            color: Colors.black, decoration: TextDecoration.none, fontSize: 22),
      )
    ],
  );
}

Widget logoAnimation() {
  return Expanded(
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie/sportSplash.json', width: 65, height: 65),
        const SizedBox(width: 10),
        Lottie.asset('assets/lottie/sportSplash.json', width: 65, height: 65),
        const SizedBox(width: 10),
        Lottie.asset('assets/lottie/sportSplash.json', width: 65, height: 65),
      ],
    ),
    const SizedBox(height: 15),
    const Center(
      child: Text("CARGANDO . . ."),
    )
  ])));
}

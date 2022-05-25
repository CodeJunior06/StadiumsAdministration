import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [logoAnimation(), byAuthor()],
        ));
  }
}

Widget byAuthor() {
  return Container(
      color: Colors.pink,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Santiago Rueda - Mobile Developer",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 22),
          )
        ],
      ));
}

Widget logoAnimation() {
  return Container(
      color: Colors.yellow,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/sportSplash.json',
              width: 100, height: 100),
          Lottie.asset('assets/lottie/sportSplash.json',
              width: 100, height: 100),
          Lottie.asset('assets/lottie/sportSplash.json',
              width: 100, height: 100),
        ],
      ));
}

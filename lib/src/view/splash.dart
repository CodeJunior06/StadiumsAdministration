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
    return Column(
      children: [logoAnimation(), byAuthor()],
    );
  }
}

Widget byAuthor() {
  return const Center(
      child: Text(
    "Santiago Rueda - Mobile Developer",
    style: TextStyle(
        color: Colors.white, decoration: TextDecoration.none, fontSize: 22),
  ));
}

Widget logoAnimation() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset('assets/lottie/sportSplash.json', width: 100, height: 100),
      Lottie.asset('assets/lottie/sportSplash.json', width: 100, height: 100),
      Lottie.asset('assets/lottie/sportSplash.json', width: 100, height: 100),
    ],
  );
}

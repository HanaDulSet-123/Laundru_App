import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laudry_app/view/dashboard.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(245, 41, 89, 121),
        child: Center(
          child: Lottie.asset(
            'assets/lottie/cleanshirt.json',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

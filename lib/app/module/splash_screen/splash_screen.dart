import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_utils/shared_preferance.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setRoute();
    });
  }

  setRoute() async {
    String ?isLogIn = await sharedPref.getKey("isLogIn");
    if (isLogIn.toString().contains("true")) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/bottomAppBarProvider",
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/logInScreen",
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: Center(
        child: Image.asset(
          "assets/logo1.png",
        ),
      ),
    );
  }
}

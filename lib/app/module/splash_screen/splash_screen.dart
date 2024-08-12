import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/app_utils/helper.dart';

import '../../app_utils/shared_preferance.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with Helper {
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setRoute();
    });
  }

  setRoute() async {
    String? isLogIn = await sharedPref.getKey("isLogIn");
    String? logInTime = await sharedPref.getKey("logInTime");
    if (logInTime != null && logInTime != "") {
      DateTime logInDateTime = DateTime.parse(json.decode(logInTime));
      int logInDay = logInDateTime.difference(DateTime.now()).inDays;

      if (isLogIn.toString().contains("true")) {
        if (logInDay <= 1) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/bottomAppBarProvider",
            (Route<dynamic> route) => false,
          );
        } else {
          debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>in else");
          gotoSplashScreen();
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/logInScreen",
          (Route<dynamic> route) => false,
        );
      }
    }else{
      Navigator.pushNamedAndRemoveUntil(
          context,
          "/logInScreen",
          (Route<dynamic> route) => false,
        );
    }
  }

  void gotoSplashScreen() async {
    bool isOk = await showCommonPopupNew(
      "Opps!!",
      "Session out.\nPlease RelogIn",
      context,
      barrierDismissible: false,
      isYesOrNoPopup: false,
    );
    if (isOk) {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save("isLogIn", "false");

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

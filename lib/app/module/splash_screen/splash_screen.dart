import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/helper.dart';
import 'package:national_wild_animal/app/module/splash_screen/refresh_token_model.dart';

import '../../app_utils/shared_preferance.dart';
import '../../app_utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with Helper {
  SharedPref sharedPref = SharedPref();
  Future<bool> getRefreshToken() async {
    Completer<bool> completer = Completer<bool>();

    try {
      // Retrieve the stored JSON string from shared preferences
      String? jsonData = await sharedPref.getKey("token");

      if (jsonData != null) {
        Utils.showProgressIndicator();
        String? refreshToken = json.decode(jsonData);
        // Call the API method using the token
        HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.getRefreshToken,
          fun: (map, code) async {
            Utils.disMissProgressIndicator();
            debugPrint(">>>>>>>>map$map");
            if (code == 200 && map['data'] != null && map['data'].isNotEmpty) {
              // Handle successful token refresh
              await sharedPref.save("token", map['data']['token']);
              completer.complete(true);
            } else {
              completer.complete(false); // Handle other scenarios
            }
          },
          token: refreshToken, // Pass the extracted token
        );
      } else {
        Utils.disMissProgressIndicator();
        completer.complete(false); // Handle case where token is null
      }
    } catch (e) {
      Utils.disMissProgressIndicator();
      completer.complete(false); // Complete with an error if something goes wrong
    }

    return completer.future;
  }

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
      int logInHours = DateTime.now().difference(logInDateTime).inHours;
      int logInMinutes = DateTime.now().difference(logInDateTime).inMinutes;
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${logInHours}");
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${logInMinutes}");
      if (isLogIn.toString().contains("true")) {
        if (logInMinutes > 475) {
          getRefreshToken().then((sta){
            if(sta){
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/bottomAppBarProvider",
                    (Route<dynamic> route) => false,
              );
            }else{
              gotoSplashScreen();
            }
          });
        } else if (logInHours <= 8) {
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
    } else {
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
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/helper.dart';
import 'package:national_wild_animal/app/module/splash_screen/refresh_token_model.dart';

import '../../app_utils/shared_preferance.dart';

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
    String jsonData = await sharedPref.getKey("userResponse"); 
    
    print(jsonData);

    // Decode the JSON string into a Map and then parse it to UserResponse
    Map<String, dynamic> jsonMap = json.decode(jsonData);
    UserResponse userResponse = UserResponse.fromJson(jsonMap);

    // Extract the token from the UserResponse object
    String? token = userResponse.data?.token;

    if (token != null) {
      // Call the API method using the token
      HttpMethodsDio().getMethodWithToken(
        api: ApiEndPoint.getRefreshToken,
        fun: (map, code) {
          if (code == 200 && map['data'] != null && map['data'].isNotEmpty) {
            // Handle successful token refresh
            completer.complete(true);
          } else {
            completer.complete(false);  // Handle other scenarios
          }
        },
        token: token, // Pass the extracted token
      );
    } else {
      completer.complete(false);  // Handle case where token is null
    }
  } catch (e) {
    completer.completeError(e);  // Complete with an error if something goes wrong
  }

  return completer.future;
}


 
  @override
  void initState() {
    super.initState();
    getRefreshToken();

    Future.delayed(Duration(seconds: 3), () {
      setRoute();
    });
  }

  setRoute() async {
    String? isLogIn = await sharedPref.getKey("isLogIn");
    String? logInTime = await sharedPref.getKey("logInTime");
    if (logInTime != null && logInTime != "") {
      DateTime logInDateTime = DateTime.parse(json.decode(logInTime));
      int logInDay = logInDateTime.difference(DateTime.now()).inDays.abs();
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${logInDay}");
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
import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:national_wild_animal/app/app_utils/utils.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    checkConnectivityAndProceed();
  }

  Future<void> checkConnectivityAndProceed() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, show a retry dialog
      showNoInternetDialog();
    } else {
      // Internet is available, proceed with route navigation
      await Future.delayed(const Duration(seconds: 3)); // Splash delay
      setRoute();
    }
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet settings and try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              checkConnectivityAndProceed(); // Retry connectivity check
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  Future<void> setRoute() async {
    try {
      String? isLogIn = await sharedPref.getKey("isLogIn");
      String? logInTime = await sharedPref.getKey("logInTime");

      if (logInTime != null && logInTime.isNotEmpty) {
        DateTime logInDateTime = DateTime.parse(json.decode(logInTime));
        int logInMinutes = DateTime.now().difference(logInDateTime).inMinutes;

        if (isLogIn.toString().contains("true")) {
          if (logInMinutes > 475) {
            // Session expired, refresh token
            bool isTokenRefreshed = await getRefreshToken();
            if (isTokenRefreshed) {
              navigateTo("/bottomAppBarProvider");
            } else {
              navigateToLoginWithPopup();
            }
          } else {
            // Session is still valid
            navigateTo("/bottomAppBarProvider");
          }
        } else {
          navigateTo("/logInScreen");
        }
      } else {
        navigateTo("/logInScreen");
      }
    } catch (e) {
      debugPrint("Error in setRoute: $e");
      navigateTo("/logInScreen");
    }
  }

  Future<bool> getRefreshToken() async {
    try {
      String? jsonData = await sharedPref.getKey("token");
      if (jsonData != null) {
        Utils.showProgressIndicator();
        String? refreshToken = json.decode(jsonData);

        // Call the API method using the token
        bool isRefreshed = await HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.getRefreshToken,
          token: refreshToken,
          fun: (map, code) async {
            Utils.disMissProgressIndicator();
            if (code == 200 && map['data'] != null && map['data'].isNotEmpty) {
              // Save the refreshed token
              await sharedPref.save("token", map['data']['token']);
              await sharedPref.save("logInTime", DateTime.now().toString());
              return true;
            }
            return false;
          },
        );
        return isRefreshed;
      }
      Utils.disMissProgressIndicator();
      return false;
    } catch (e) {
      Utils.disMissProgressIndicator();
      return false;
    }
  }

  void navigateTo(String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  void navigateToLoginWithPopup() async {
    bool isOk = await showCommonPopupNew(
      "Oops!!",
      "Session expired.\nPlease Relogin",
      context,
      barrierDismissible: false,
      isYesOrNoPopup: false,
    );
    if (isOk) {
      await sharedPref.save("isLogIn", "false");
      navigateTo("/logInScreen");
    }
  }

  Future<bool> showCommonPopupNew(
    String title,
    String message,
    BuildContext context, {
    bool barrierDismissible = true,
    bool isYesOrNoPopup = true,
  }) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            if (isYesOrNoPopup)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false on "No"
                },
                child: const Text('No'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true on "Yes" or "OK"
              },
              child: const Text( 'OK'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: Center(
        child: Image.asset(
          "assets/logo1.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

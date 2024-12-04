import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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

  // Method to get current location and store it in shared preferences
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    try {
      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

      // Save latitude and longitude in shared preferences
      await sharedPref.save("latitude", position.latitude.toString());
      await sharedPref.save("longitude", position.longitude.toString());

      // Get address details from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String currentLocation =
            "${place.locality}, ${place.administrativeArea}, ${place.country}";
        print("Location: $currentLocation");

        // Save the current location in shared preferences
        await sharedPref.save("currentLocation", currentLocation);
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<bool> getRefreshToken() async {
    Completer<bool> completer = Completer<bool>();

    try {
      String? jsonData = await sharedPref.getKey("token");

      if (jsonData != null) {
        Utils.showProgressIndicator();
        String? refreshToken = json.decode(jsonData);
        HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.getRefreshToken,
          fun: (map, code) async {
            Utils.disMissProgressIndicator();
            if (code == 200 && map['data'] != null && map['data'].isNotEmpty) {
              await sharedPref.save("token", map['data']['token']);
              completer.complete(true);
            } else {
              completer.complete(false);
            }
          },
          token: refreshToken,
        );
      } else {
        Utils.disMissProgressIndicator();
        completer.complete(false);
      }
    } catch (e) {
      Utils.disMissProgressIndicator();
      completer.complete(false);
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    Future.delayed(const Duration(seconds: 3), () {
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
      if (isLogIn.toString().contains("true")) {
        if (logInMinutes > 475) {
          getRefreshToken().then((sta) {
            if (sta) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/bottomAppBarProvider",
                (Route<dynamic> route) => false,
              );
            } else {
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
      "Oops!!",
      "Session out.\nPlease RelogIn",
      context,
      barrierDismissible: false,
      isYesOrNoPopup: false,
    );
    if (isOk) {
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

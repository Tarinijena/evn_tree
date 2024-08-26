import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';

import '../module/home_screen/bottom_app_bar.dart';

import '../module/login_screen/login_screen.dart';
import '../module/sign_up_screen/sign_up_screen.dart';
import '../module/splash_screen/splash_screen.dart';

class AppRoutes {
  // late BuildContext context;
  static Map<String, WidgetBuilder> appRoutes = {

    "/splashScreen": (context) => const SplashScreen(),
    "/logInScreen": (context) => const LoginScreen(),
    "/signUpScreen": (context) => const SignUpScreen(),
    "/homeScreen": HomeScreen.builder,
    "/bottomAppBarProvider": BottomAppBarPage.builder,
    
  };
}
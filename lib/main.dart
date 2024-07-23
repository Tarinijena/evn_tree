import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:national_wild_animal/Demo.dart';
import 'package:national_wild_animal/app/screens/Demo.dart';
import 'package:national_wild_animal/app/screens/ProfilePage.dart';
import 'package:national_wild_animal/app/screens/EventScreen.dart';
import 'package:national_wild_animal/app/screens/HomeScreen.dart';
import 'package:national_wild_animal/app/screens/login_screen.dart';
import 'package:national_wild_animal/app/screens/profile_screen.dart';



void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:  Brightness.dark,
    statusBarBrightness:  Brightness.dark,
    // systemNavigationBarColor: themeData.scaffoldBackgroundColor,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness:  Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:FestivalList(), 
    );
  }
}



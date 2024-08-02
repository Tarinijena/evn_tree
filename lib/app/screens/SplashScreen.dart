import 'dart:async';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds: 10),
    ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()))
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
               Image.asset("assets/logo1.png",),
               //Image.asset("assets/logo2.png")
           ],
        ),
          
      ),
    );
  }
}
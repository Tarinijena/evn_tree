import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/module/login_screen/login_screen.dart';

class NoInternetPage extends StatefulWidget {
  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  bool isChecking = false;

  Future<void> reload() async {
    setState(() {
      isChecking = true;
    });
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isChecking = false;
    });
    if (connectivityResult != ConnectivityResult.none) {
      // Internet restored, navigate to Login Page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      // Still no internet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Still no internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('No Internet')),
      body: Center(
        child: isChecking
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: reload,
                child: Text('Reload'),
              ),
      ),
    );
  }
}

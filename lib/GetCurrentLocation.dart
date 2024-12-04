
import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {

  SharedPref sharedPref = SharedPref();

   String? latitudeData;
   String? longitudeData;
   String? locationData;

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    latitudeData=await sharedPref.getKey('latitude');
    longitudeData=await sharedPref.getKey('longitude');
    locationData=await sharedPref.getKey('currentLocation');
  }

  @override
  Widget build(BuildContext context) {

  

    return Scaffold(
        body: Center(
            child: Column(
                children: [
                    Text("$longitudeData"),
                    Text("$latitudeData"),
                    Text("$locationData")
                ],
            ),
        ),
    );
  }
}
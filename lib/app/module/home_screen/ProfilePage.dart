import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';

import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/common_widgets/custom_text_field.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/home_screen_provider.dart';
import 'package:national_wild_animal/app/module/profile_screen/profile_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserData? userData;

  //these are the controller for text form field...................
   late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController mobileNoController;
  late TextEditingController rolesController;

  SharedPref sharedPref = SharedPref();
Future<bool> getUserProfileData() async {
  Completer<bool> completer = Completer<bool>();

  try {
    String data = await sharedPref.getKey("token");
    String token = json.decode(data);

    HttpMethodsDio().getMethodWithToken(
      api: ApiEndPoint.getUserProfile,
      fun: (map, code) {
        if (code == 200 && map['data'] != null && map['data'].isNotEmpty) {
          Map<String, dynamic> parsedJson = map;  // No need to decode again

          if (parsedJson['status']) {
            userData = UserData.fromJson(parsedJson['data']);

            setState(() {
              fullNameController.text = userData?.fullName ?? '';
              emailController.text = userData?.email ?? '';
              mobileNoController.text = userData?.mobileNo ?? '8249124088';
              rolesController.text = userData!.roles.map((role) => role.roleName).join(', ');
            });

            completer.complete(true);  // Complete the future successfully
          } else {
            completer.complete(false);  // Handle status false
          }
        } else {
          completer.complete(false);  // Handle other scenarios
        }
      },
      token: token,
    );
  } catch (e) {
    completer.completeError(e);  // Complete with an error if something goes wrong
  }

  return completer.future;
}

  @override
  void initState() {
    
    super.initState();

      // Initialize the controllers with the data from userData
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNoController = TextEditingController();
    rolesController = TextEditingController();
    
    getUserProfileData();
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    fullNameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    rolesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    color: Color(0xFF2A233D),
                  ),
                  Positioned(
                    bottom: -45,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          "assets/indian.jpeg"), // Replace with your image URL
                    ),
                  ),
                  Positioned(top: 20, child: Image.asset("assets/logo1.png"))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                '${userData?.fullName}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: fullNameController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Name",
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: emailController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Email",
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      controller: mobileNoController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Phone Number",
                    ),
                    Text(
                      "Designation",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      readOnly: true,
                      controller: rolesController,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Designation",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonButton(
                      buttonText: "SAVE PROFILE",
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RectangularContainerWithImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: Color(0xFF2A233D),
        ),
        Positioned(
          bottom: -45,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://tse2.mm.bing.net/th?id=OIP.90o6OQ7-jGqViljHVhhfmQHaE8&pid=Api&P=0&h=220'), // Replace with your image URL
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/common_widgets/custom_text_field.dart';

import '../../app_utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                      backgroundImage: AssetImage("assets/indian.jpeg"), // Replace with your image URL
                    ),
                  ),
                  Positioned(top: 20, child: Image.asset("assets/logo1.png"))
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Tarini Kumar Jena",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Name",
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Email",
                    ),
                    Text(
                      "Website",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Website",
                    ),
                    Text(
                      "BioData",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffB74BFF)),
                      ),
                      inputHint: "Enter Biodata",
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

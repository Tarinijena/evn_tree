import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    Uint8List? _image;
  File? selectedIMage;

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
                    child: _image != null
                ? CircleAvatar(
                    radius: 60, backgroundImage: MemoryImage(_image!))
                : const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  ),
                  ),
                  Positioned(top: 20, child: Image.asset("assets/logo1.png")),
                  Positioned(
                    //top: -55,
                    bottom: 45,
                    left: 120,
                    child: IconButton(onPressed: () {
                       showImagePickerOption(context);
                  }, icon:Icon(Icons.add_a_photo,size: 35,color: Color(0xffB74BFF),)))
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

   void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Color(0xffB74BFF),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
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

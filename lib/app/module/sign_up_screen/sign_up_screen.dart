import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:national_wild_animal/app/app_utils/utils.dart';
import 'package:national_wild_animal/app/common_widgets/opt_text_field.dart';
import 'package:national_wild_animal/app/common_widgets/show_snack_bar.dart';
import 'package:national_wild_animal/app/module/login_screen/signup_otp_verification.dart';

import '../../common_widgets/background_widget.dart';
import '../../common_widgets/common_text_field_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
 TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
   //these controller for password fiels
   TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController password3 = TextEditingController();
  TextEditingController password4 = TextEditingController();

  //these controller for date of birth
   TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  //this is for focus node............
      final FocusNode firstFocusNode = FocusNode();
  final FocusNode secondFocusNode = FocusNode();
  final FocusNode thirdFocusNode = FocusNode();
  final FocusNode fourthFocusNode = FocusNode();
  

  SharedPref sharedPref = SharedPref();
  signupUser() {
    String password;
    String dateOfBirth;
    password =
        password1.text + password2.text + password3.text + password4.text;
        dateOfBirth=dateController.text+"/"+monthController.text+"/"+yearController.text;
    try {
      // Prepare the JSON data from the input fields
      Map<String, dynamic> jsonData = {
        "fullName": nameController.text,
        "emailOrMobile": emailController.text,
        "dateOfBirth": dateOfBirth,
        "password": password,
      };

      HttpMethodsDio().postMethod(
          api: ApiEndPoint.signupUser,
          json: jsonData,
          fun: (map, code) async {
                 Utils.showProgressIndicator();
            await Future.delayed(Duration(seconds: 2));
            Utils.disMissProgressIndicator();
             
            print(code);
            if (code == 200) {
              print("Data store in database successfully..........");

              Utils.disMissProgressIndicator();
              showDialog(
                context: context,
                builder: (context) {
                  return Hero(
                      tag: 'otp',
                      child: SignupOtpVerification.builder(
                          context, emailController.text));
                },
              );
            } else {
              print("Unable to store data in database........");
              Utils.disMissProgressIndicator();
              ShowSnackBar.showError(context, "Something went wrong");
            }
          });
    } catch (e) {
      Utils.disMissProgressIndicator();
      ShowSnackBar.showError(context, "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double usableHeight = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
              height: usableHeight,
              child: BackgroundWidget(
                size: size,
                btnOnTap: () async {
                  if (nameController.text == '') {
                    ShowSnackBar.showError(context, "Please enter userName");
                  } else if (emailController.text == '') {
                    ShowSnackBar.showError(
                        context, "Please enter email / phone number");
                  } else if (dateController.text == '') {
                    ShowSnackBar.showError(
                        context, "Please enter date");
                  }  else if (monthController.text == '') {
                    ShowSnackBar.showError(
                        context, "Please enter month");
                  } else if (yearController.text == '') {
                    ShowSnackBar.showError(
                        context, "Please enter year");
                  }
                  
                  else if (password1 == '') {
                    ShowSnackBar.showError(context, "Please enter password");
                  }
                  else if (password2 == '') {
                    ShowSnackBar.showError(context, "Please enter password");
                  }else if (password3 == '') {
                    ShowSnackBar.showError(context, "Please enter password");
                  }else if (password4 == '') {
                    ShowSnackBar.showError(context, "Please enter password");
                  }
                   else {
                    signupUser();
                  }

                  //signupUser();
                  // Navigator.pushNamed(context, "/logInScreen");
                  //debugPrint(">>>>>>>>>>>>>btnOnTap Call");
                },
                buttonText: 'Sign UP',
                footerOnTap: () {
                  Navigator.pushNamed(context, "/logInScreen");
                  debugPrint(">>>>>>>>>>>>>footerOnTap Call");
                },
                footerTextOne: "Already have an account ? ",
                footerTextTwo: 'sign-in',
                widgetLst: [
                  SizedBox(
                    height: 25,
                  ),
                  CommonTextFieldView(
                    controller: nameController,
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "Full Name",
                    hintText: "Full Name",

                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.person,
                    radius: 1,
                    height: 50,
                    suffixIconColor: null,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextFieldView(
                    controller: emailController,
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "email/phone number",
                    hintText: "email/phone number",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {
                      emailController.value=emailController.value.copyWith(text: txt.toLowerCase(),);
                    },
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.mail_outlined,
                    suffixIconColor: null,
                    radius: 1,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text("Date of Birth",style: TextStyle(fontSize: 14,color: Colors.white,),),
                    ),
                  ],),
                  Row(children: [
                    
                    Expanded(
                      child: CommonTextFieldView(
                                          controller: dateController,
                                          // errorText: _errorFName,
                                          padding: const EdgeInsets.only( ),
                                          titleText: "DD",
                                          hintText: "DD",
                                          keyboardType: TextInputType.number,
                                          onChanged: (String txt) {},
                                          isAllowTopTitleView: false,
                                          suffixIcon: Icons.date_range,
                                          suffixIconColor: null,
                                          radius: 1,
                                          height: 50,
                                        ),
                    ),
                    SizedBox(width: 10,),
                     //Text("Day",style: TextStyle(fontSize: 14,color: Colors.white,),),
                     Expanded(
                       child: CommonTextFieldView(
                                           controller: monthController,
                                           // errorText: _errorFName,
                                           padding: const EdgeInsets.only(),
                                           titleText: "MM",
                                           hintText: "MM",
                                           keyboardType: TextInputType.number,
                                           onChanged: (String txt) {},
                                           isAllowTopTitleView: false,
                                           suffixIcon: Icons.date_range,
                                           suffixIconColor: null,
                                           radius: 1,
                                           height: 50,
                                         ),
                     ),
                     SizedBox(width: 3,),
                     //Text("Day",style: TextStyle(fontSize: 14,color: Colors.white,),),
                     Expanded(
                       child: CommonTextFieldView(
                                           controller: yearController,
                                           // errorText: _errorFName,
                                           padding: const EdgeInsets.only(),
                                           titleText: "YYYY",
                                           hintText: "YYYY",
                                           keyboardType: TextInputType.number,
                                           onChanged: (String txt) {},
                                           isAllowTopTitleView: false,
                                           suffixIcon: Icons.date_range,
                                           suffixIconColor: null,
                                           radius: 1,
                                           height: 50,
                                         ),
                     )
                  ],),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 6,),
                            Text(
                          "Enter 4-digit Password",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              ),
                        ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: OptTextField(
                                
                                controller: password1,
                                keyboardType: TextInputType.text,
                                focusNode: firstFocusNode,
                              ),
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              child: OptTextField(
                                controller: password2,
                                keyboardType: TextInputType.text,
                                focusNode: secondFocusNode,
                                previousFocusNode: firstFocusNode,
                              ),
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              child: OptTextField(
                                controller: password3,
                                keyboardType: TextInputType.text,
                                focusNode: thirdFocusNode,
                                previousFocusNode: secondFocusNode,
                              ),
                            ),
                            SizedBox(
                              width: 31,
                            ),
                            Expanded(
                              child: OptTextField(
                                controller: password4,
                                keyboardType: TextInputType.text,
                                focusNode: fourthFocusNode,
                                previousFocusNode: thirdFocusNode,
                              ),
                            ),
                           
                          ],
                        )
                      ],
                    )
                ],
                headerText: 'Sign Up',
              )),
        ),
      ),
    );
  }
}

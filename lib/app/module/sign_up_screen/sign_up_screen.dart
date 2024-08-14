import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:national_wild_animal/app/app_utils/utils.dart';
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

  TextEditingController passwordController = TextEditingController();

  SharedPref sharedPref = SharedPref();
  signupUser() {
    try {
      // Prepare the JSON data from the input fields
      Map<String, dynamic> jsonData = {
        "fullName": nameController.text,
        "emailOrMobile": emailController.text,
        "dateOfBirth": birthController.text,
        "password": passwordController.text,
      };

      HttpMethodsDio().postMethod(
          api: ApiEndPoint.signupUser,
          json: jsonData,
          fun: (map, code) async {
            Utils.showProgressIndicator();
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
                  } else if (birthController.text == '') {
                    ShowSnackBar.showError(
                        context, "Please enter date of birth");
                  } else if (passwordController.text == '') {
                    ShowSnackBar.showError(context, "Please enter password");
                  } else {
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
                    titleText: "email",
                    hintText: "email",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.mail_outlined,
                    suffixIconColor: null,
                    radius: 1,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextFieldView(
                    controller: birthController,
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "DateOfBirth",
                    hintText: "DateOfBirth",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.date_range,
                    suffixIconColor: null,
                    radius: 1,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextFieldView(
                    controller: passwordController,
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "password",
                    hintText: "password",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.key,
                    suffixIconColor: null,
                    radius: 1,
                    height: 50,
                  ),
                ],
                headerText: 'Sign Up',
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/common_widgets/opt_text_field.dart';

import '../../app_utils/shared_preferance.dart';
import '../../app_utils/utils.dart';
import '../../common_widgets/background_widget.dart';
import '../../common_widgets/common_text_field_view.dart';
import '../../common_widgets/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userName = TextEditingController();

  //controller for password field
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController password3 = TextEditingController();
  TextEditingController password4 = TextEditingController();

  //this is for focus node.....................

    final FocusNode firstFocusNode = FocusNode();
  final FocusNode secondFocusNode = FocusNode();
  final FocusNode thirdFocusNode = FocusNode();
  final FocusNode fourthFocusNode = FocusNode();

  String? password;

  SharedPref sharedPref = SharedPref();
  loginUser() {
    String password;
    password =
        password1.text + password2.text + password3.text + password4.text;
    try {
      // Prepare the JSON data from the input fields

      HttpMethodsDio().postMethod(
          api: ApiEndPoint.loginVerify(userName.text, password),
          fun: (map, code) async {
            Utils.showProgressIndicator();
            await Future.delayed(Duration(seconds: 2));
            Utils.disMissProgressIndicator();
            print(code);
            if (code == 200) {
              print("User Login Successfully...........");

              Utils.disMissProgressIndicator();
              await sharedPref.save("isLogIn", "true");
              await sharedPref.save("token", map['data']['token']);
              await sharedPref.save("fullName", map['data']['fullName']);
              await sharedPref.save("mobileNo", map['data']['mobileNo']);
              await sharedPref.save("userName", map['data']['userName']);
              await sharedPref.save("email", map['data']['email']);
              await sharedPref.save("logInTime", DateTime.now().toString());
              if (map['data']['roles'] != null &&
                  map['data']['roles'].length > 0) {
                await sharedPref.save(
                    'roles', map['data']['roles'][0]["roleName"]);
              }
              Navigator.pushNamed(context, "/bottomAppBarProvider");
              debugPrint(">>>>>>>>>>>>>footerOnTap Call");
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
          child: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                height: usableHeight,
                child: BackgroundWidget(
                  size: size,
                  btnOnTap: () async {
                    if (userName.text == "") {
                      ShowSnackBar.showError(
                          context, "Please enter email / phone No");
                    } else if (password == "") {
                      ShowSnackBar.showError(context, "Please enter Password");
                    } else {
                      loginUser();
                    }
                  },
                  buttonText: 'Log In',
                  footerOnTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/signUpScreen",(Route<dynamic> route) => false,);
                  },
                  footerTextOne: "You don't have an account ? ",
                  footerTextTwo: 'sign-up',
                  widgetLst: [
                    CommonTextFieldView(
                      controller: userName,
                      // errorText: _errorFName,
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      titleText: "email / phone No",
                      hintText: "email / phone No",
                      keyboardType: TextInputType.text,
                      onChanged: (String txt) {
                        userName.value=userName.value.copyWith(text: txt.toLowerCase(),);
                      },
                      isAllowTopTitleView: false,
                      suffixIcon: Icons.mail_outlined,
                      radius: 1,
                      //height: 50,
                      suffixIconColor: null,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    /*CommonTextFieldView(
                      controller: password,
                      // errorText: _errorFName,
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      titleText: "4-digit Password",
                      hintText: "4-digit Password",
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                      isAllowTopTitleView: false,
                      suffixIcon: Icons.key,
                      radius: 1,
                      //height: 50,
                      suffixIconColor: null,
                    )*/
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: OptTextField(
                                 
                                  controller: password1,
                                  keyboardType: TextInputType.number,
                                   focusNode: firstFocusNode,
                                ),
                              ),
                              SizedBox(
                                width: 31,
                              ),
                              Expanded(
                                child: OptTextField(
                                  controller: password2,
                                  keyboardType: TextInputType.number,
                                  focusNode: secondFocusNode,
                                  previousFocusNode: firstFocusNode,
                                  
                                ),
                              ),
                              SizedBox(
                                width: 31,
                              ),
                              Expanded(
                                child: OptTextField(
                                  controller: password3,
                                  keyboardType: TextInputType.number,
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
                                  keyboardType: TextInputType.number,
                                  focusNode: fourthFocusNode,
                                  previousFocusNode: thirdFocusNode,
                                ),
                              ),
                             
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                  headerText: 'Welcome Back ! ',
                )),
          ),
        ],
      )),
    );
  }
}

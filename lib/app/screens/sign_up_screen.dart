import 'package:flutter/material.dart';

import 'package:national_wild_animal/app/screens/login_screen.dart';

import '../common_widgets/background_widget.dart';
import '../common_widgets/common_text_field_view.dart';

class SignUpScreen extends StatefulWidget {
  
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double usableHeight = size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
              height: usableHeight,
              child: BackgroundWidget(size: size,
                btnOnTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen(),));
                  debugPrint(">>>>>>>>>>>>>btnOnTap Call");
                }, buttonText: 'Sign UP', footerOnTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen(),));
                  debugPrint(">>>>>>>>>>>>>footerOnTap Call");
                },
                footerTextOne: "Already have an account ? ", footerTextTwo: 'sign-in', widgetLst: [
                  SizedBox(height: 25,),
                  CommonTextFieldView(
                    controller: TextEditingController(),
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "Full Name",
                    hintText:"Full Name",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.person,
                    radius: 1,
                    height: 40,
                    suffixIconColor: null,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextFieldView(
                    controller: TextEditingController(),
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "email",
                    hintText:"email",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.mail_outlined,
                    suffixIconColor: null,
                    radius: 1,
                    height: 40,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextFieldView(
                    controller: TextEditingController(),
                    // errorText: _errorFName,
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    titleText: "password",
                    hintText:"password",
                    keyboardType: TextInputType.name,
                    onChanged: (String txt) {},
                    isAllowTopTitleView: false,
                    suffixIcon: Icons.key,
                    suffixIconColor: null,
                    radius: 1,
                    height: 40,
                  ),

                ],
                headerText: 'Sign Up',)



            /* Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
            Expanded(
                flex:1,child: Container()),
                Image.asset("assets/logo1.png"),
                Expanded(
                    flex:1,child: Container()),
                SizedBox(
                  height: size.height*0.65,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                          child: SizedBox(
                            height: size.height*0.45,
                            child: Container(
                              // height: size.height*0.5,
                              // width: size.width*0.95,
                              decoration: BoxDecoration(
                                color: const Color(0xFF231D32),           // Background color
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: const Color(0xFF333649))// Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0,right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonTextFieldView(
                                      controller: TextEditingController(),
                                      // errorText: _errorFName,
                                      padding: const EdgeInsets.only(left: 2, right: 2),
                                      titleText: "email / phone No",
                                      hintText:"email / phone No",
                                      keyboardType: TextInputType.name,
                                      onChanged: (String txt) {},
                                      isAllowTopTitleView: false,
                                      radius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: -60,
                        left: 0,
                        right: 0,

                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/logo2.png',
                                width: 135,
                                height: 190,
                                fit: BoxFit.cover,  // Adjust the fit as per your requirement
                              ),
                              Text("Welcome Back!",style: TextStyles(context).googleRubikFontsForButtonText(fontWeight: FontWeight.w500,fontSize: 22),)
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                       bottom: 55,
                        left: 0,
                        right: 0,

                        child: CommonButton(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          buttonText: "Log In",
                          radius: 29,
                          onTap: () {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You don't have an account ? ",
                      textAlign: TextAlign.center,
                      style: TextStyles(context).googleRubikFontsForButtonText(fontSize: 12,fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () {
                        Navigator.pushNamed(context, "/signupScreen");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "sign-up",
                          style:TextStyles(context).googleRubikFontsForText2(fontSize: 12,fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    flex:1,child: Container()),
              ],
            ),*/
          ),
        ),
      ),
    );
  }
}

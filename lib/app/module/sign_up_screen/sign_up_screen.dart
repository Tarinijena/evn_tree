import 'package:flutter/material.dart';

import '../../common_widgets/background_widget.dart';
import '../../common_widgets/common_text_field_view.dart';

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
                  Navigator.pushNamed(context, "/logInScreen");
                  debugPrint(">>>>>>>>>>>>>btnOnTap Call");
                }, buttonText: 'Sign UP', footerOnTap: () {
                  Navigator.pushNamed(context, "/logInScreen");
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
                    height: 50,
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
                    height: 50,
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
                    height: 50,
                  ),

                ],
                headerText: 'Sign Up',)
          ),
        ),
      ),
    );
  }
}

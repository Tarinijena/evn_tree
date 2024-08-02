import 'package:flutter/material.dart';
import 'package:national_wild_animal/OTPScreen/OtpVerificationPage.dart';

import 'package:national_wild_animal/app/screens/sign_up_screen.dart';

import '../common_widgets/background_widget.dart';

import '../common_widgets/common_text_field_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userName=TextEditingController();

  String? user;
  bool _isLoading = false;


   

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double usableHeight = size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
          child: SizedBox(
            height: usableHeight,
            child: BackgroundWidget(size: size,
              btnOnTap: () async {
                
                 setState(() {
                      _isLoading = true;
                    });

                    await Future.delayed(const Duration(seconds: 2));

                    setState(() {
                      _isLoading = false;
                    });
                
                 showDialog(context: context, builder:(context) {

                        return Hero(
                          tag: 'otp',
                          child:OtpVerificationScreen(user: userName.text,));
                   },);
              }, buttonText: 'Log In', footerOnTap: () {
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
              },
              footerTextOne: "You don't have an account ? ", footerTextTwo: 'sign-up', widgetLst: [
                CommonTextFieldView(
                  controller:userName,
                  // errorText: _errorFName,
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  titleText: "email / phone No",
                  hintText:"email / phone No",
                  keyboardType: TextInputType.name,
                  onChanged: (String txt) {},
                  isAllowTopTitleView: false,
                  suffixIcon: Icons.mail_outlined,
                  radius: 1,
                  //height: 50,
                  suffixIconColor: null,

                ),
              ],
              headerText: 'Welcome Back ! ',
              
              )


            
           
          
          ),
          
        ),
        if (_isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ),
           
          ],
        )

          

      ),

    );
  }
}

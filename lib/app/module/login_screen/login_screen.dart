import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';

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
  TextEditingController password = TextEditingController();


   loginUser(){
       try {
      // Prepare the JSON data from the input fields
    

      HttpMethodsDio().postMethod(
          api: ApiEndPoint.loginVerify(userName.text, password.text),
          
          fun: (map, code) async {
           Utils.showProgressIndicator();
                      await Future.delayed(Duration(seconds: 2));
                      Utils.disMissProgressIndicator();
            print(code);
            if (code == 200) {
              print("User Login Successfully...........");

              
              Utils.disMissProgressIndicator();
              
              Navigator.pushNamed(context, "/homeScreen");
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
    double usableHeight = size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
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

                      ShowSnackBar.showError(context, "Please enter email / phone No");
                    } else if (password.text == "") {
                      ShowSnackBar.showError(context, "Please enter Password");
                    } else {
                      loginUser();
                      
                    }
                    
                    
                    
                    

                   
                  },
                  buttonText: 'Log In',
                  footerOnTap: () {
                    Navigator.pushNamed(context, "/signUpScreen");
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
                      keyboardType: TextInputType.name,
                      onChanged: (String txt) {},
                      isAllowTopTitleView: false,
                      suffixIcon: Icons.mail_outlined,
                      radius: 1,
                      //height: 50,
                      suffixIconColor: null,
                    ),
                    CommonTextFieldView(
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

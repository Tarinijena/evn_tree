import 'package:flutter/material.dart';

import '../app_theme/text_styles.dart';
import 'common_button.dart';
import 'common_text_field_view.dart';

class BackgroundWidget extends StatelessWidget {
  final Size size;
  final String footerTextOne;
  final String footerTextTwo;
  final String buttonText;
  final String headerText;
  final VoidCallback btnOnTap;
  final VoidCallback footerOnTap;
  final List<Widget> widgetLst;
  const BackgroundWidget({super.key,required this.size,required this.btnOnTap,
    required this.buttonText,required this.footerOnTap,required this.footerTextOne,
    required this.footerTextTwo,required this.widgetLst,required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: size.height*0.8,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                  child: SizedBox(
                    height: size.height*0.60,
                    child: Container(
                      // height: size.height*0.5,
                      // width: size.width*0.95,
                      decoration: BoxDecoration(
                          color: const Color(0xFF231D32),           // Background color
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF333649))// Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0,right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widgetLst,
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
                      
                      Text(headerText,style: TextStyles(context).googleRubikFontsForButtonText(fontWeight: FontWeight.w500,fontSize: 22),),
                      
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,

                child: CommonButton(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  buttonText: buttonText,
                  radius: 29,
                  onTap: btnOnTap,
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
              footerTextOne,
              textAlign: TextAlign.center,
              style: TextStyles(context).googleRubikFontsForButtonText(fontSize: 16,fontWeight: FontWeight.w500),
            ),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: footerOnTap,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  footerTextTwo,
                  style:TextStyles(context).googleRubikFontsForText2(fontSize: 14,fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        Expanded(
            flex:1,child: Container()),
      ],
    );
  }
}

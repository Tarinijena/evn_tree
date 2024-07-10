
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_wild_animal/app/screens/HomeWidget/BottomAppBar.dart';

import 'package:national_wild_animal/app/screens/profile_screen.dart';
import 'package:national_wild_animal/app/screens/login_screen.dart';


class OtpVerificationScreen extends StatefulWidget {

  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

    bool invalidOtp=false;

     TextEditingController num1=TextEditingController();
     TextEditingController num2=TextEditingController();
     TextEditingController num3=TextEditingController();
     TextEditingController num4=TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 40,bottom: 40),
            height:MediaQuery.of(context).size.height*0.7,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Dialog(
                 backgroundColor: const Color(0xFF231D32),
                 
              
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40,left: 20,right: 20,bottom: 40),
                    child: Column(
                       children: [
                         
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             
                             Image.asset("assets/logo1.png"),


                      
                             ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                               child: Container(
                                 child: IconButton(onPressed: () {
                                                       
                                    Navigator.pop(context);
                                    
                                   
                                 }, icon:Icon(Icons.close,size: 35,color: Colors.white,)),
                               ),
                             )
                           ],
                         ),
                      
                         SizedBox(height: 40,),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
 
                              Text("Enter OTP",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30
                              ),),

                              SizedBox(height: 40,),

                               Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 myInputField(context, num1),
                                 SizedBox(width: 5,),
                                 myInputField(context, num2),
                                 SizedBox(width: 5,),
                                 myInputField(context, num3),
                                 SizedBox(width: 5,),
                                 myInputField(context, num4),
                              ],
                          ),
              
                          SizedBox(height: 20,),
                          Text(invalidOtp?'Invalid OTP':'',style: TextStyle(fontSize: 15,color: Colors.red),),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF760ABE), Color(0xFFB74BFF)], // Define your gradient colors here
                      ),
                      //borderRadius: BorderRadius.circular(radius),
                    ),
                            child: ElevatedButton(
                              
                              onPressed: (){
                                  
                                final otp=num1.text+num2.text+num3.text+num4.text;
                                  
                                if(otp=='1234')
                                {
                                    //then go to next screen........
                                    setState(() {
                                     invalidOtp=false;
                                     
                                   });
                                   Navigator.push(context,MaterialPageRoute(builder: (context) =>BottomAppBarPage(),));
                                }
                                else
                                {
                                   setState(() {
                                     invalidOtp=true;
                                   });
                                }
                                  
                            } , 
                            
                            
                            child:const Text("Verify",style: TextStyle(fontSize: 20,
                            color: Colors.white
                            ),),style: ElevatedButton.styleFrom(elevation: 3,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            maximumSize: Size.fromHeight(50)
                            ),
                             
                            ),
                          )
                           ],
                        )
                          
              
                       ],
                    ),
                  ),
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget myInputField(BuildContext context,TextEditingController controller)
{

     return Container(

        height: 70,
        width: 60,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)
        ),

       child: TextField(
        decoration: InputDecoration(
           counterText: '',
           border: OutlineInputBorder(borderSide: BorderSide.none)
        ),
        maxLength: 1,

        cursorHeight: 50,
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 35,color:Colors.white),
        textAlign: TextAlign.center,
        onChanged: (value) {
          if(value.length==1)
          {
             FocusScope.of(context).nextFocus();
          }
        },
        
         
       ),
     );
    
}
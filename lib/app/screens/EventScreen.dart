
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/screens/HomeWidget/EventScreenWidget/custom_text_field.dart';
import 'package:national_wild_animal/app/screens/profile_screen.dart';

class EventScreen extends StatefulWidget {

  

  EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  bool check1=false;
  bool check2=false;

  DateTime selectedDate = DateTime.now();

  TextEditingController date1=TextEditingController();

  List item=["Create Event","Event Listing"];

  List country=["India","Pakistan","China","Japan"];

  int current=0;
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
         
         backgroundColor: const Color(0xFF231D32),
         body: SafeArea(
           child: DefaultTabController(
            length: 2,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                     CustomAppBar(),
                     SizedBox(height: 20,),
                     
                     Container(
                      height: 33,
                      decoration: BoxDecoration(
                        color: Colors.transparent
                      ),
                       
                       child: TabBar(
                        
                         physics: ClampingScrollPhysics(),
                         
                         unselectedLabelColor: Color(0xffB74BFF),
                         indicatorSize: TabBarIndicatorSize.label,
                           dividerColor: Colors.transparent,
                         indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffB74BFF),
                            border: Border(
                              bottom: BorderSide(color: Colors.transparent)
                            )
                         ),
                         tabs: [
                           Tab(
                           child: Container(
                           height: 33,
                           width: 100,
                           decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xffB74BFF),width: 1)
                           ),
                           child: Align(
                              alignment: Alignment.center,
                              child: Text("Create Event",style: TextStyle(color: Colors.white),),
                           ),
                                                         ),
                                                      ),
                                                      Tab(
                                                         child: Container(
                            height: 33,
                           width: 100,
                           decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xffB74BFF),width: 1)
                           ),
                           child: Align(
                              alignment: Alignment.center,
                              child: Text("Event Listed",style: TextStyle(color: Colors.white),),
                           ),
                                                         ),
                                                      )
                         ]),
                     ),

                     Expanded(child:TabBarView(children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 23,right: 23,top: 10),
                           child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                             child: Column(
                                children: [
                                    
                                    CustomTextField(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffB74BFF)
                                        ),
                             
                                      ),
                                      inputHint:"Event Name" ,
                                  ),
                                    SizedBox(height: 3,),
                                     CustomTextField(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffB74BFF)
                                        ),
                             
                                      ),
                                      inputHint:"Address Line 1" ,
                                  ),
                                    SizedBox(height: 3,),
                                     CustomTextField(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffB74BFF)
                                        ),
                             
                                      ),
                                      inputHint:"Landmark" ,
                                  ),
                                    SizedBox(height: 3,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Expanded(
                                              child: Container(
                                                 height: 50,
                                                 decoration: ShapeDecoration(
                                                  shape:RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,color: Color(0xffB74BFF)
                                                      ),
                                                      borderRadius: BorderRadius.circular(14)
                                                  ) ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                        SizedBox(width: 20,),
                                                        //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                                                
                                                            hint: Text("Country",style: TextStyle(color: Colors.white),),
                                                            value: selectedCountry,
                                                            onChanged: (String? newValue){
                                                               setState(() {
                                                                   selectedCountry=newValue;
                                                               });
                                                            },
                                                            items:country.map((e)=>DropdownMenuItem<String>(
                                                              value: e,
                                                              child: Text(e,style: TextStyle(color: Colors.grey.shade800),))).toList() 
                                                              
                                                              ),
                                                        ),
                                                        
                                                     ],
                                                  ) ,
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                              Expanded(
                                                child: Container(
                                                 height: 50,
                                                 decoration: ShapeDecoration(
                                                  shape:RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,color: Color(0xffB74BFF)
                                                      ),
                                                      borderRadius: BorderRadius.circular(14)
                                                  ) ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                        SizedBox(width: 20,),
                                                        //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                                                  
                                                            hint: Text("Country",style: TextStyle(color: Colors.white),),
                                                            value: selectedCountry,
                                                            onChanged: (String? newValue){
                                                               setState(() {
                                                                   selectedCountry=newValue;
                                                               });
                                                            },
                                                            items:country.map((e)=>DropdownMenuItem<String>(
                                                              value: e,
                                                              child: Text(e,style: TextStyle(color: Colors.grey.shade800),))).toList() 
                                                              
                                                              ),
                                                        ),
                                                        
                                                     ],
                                                  ) ,
                                                                                          ),
                                              )
                                        ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Expanded(
                                              child: Container(
                                                 height: 50,
                                                 decoration: ShapeDecoration(
                                                  shape:RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,color: Color(0xffB74BFF)
                                                      ),
                                                      borderRadius: BorderRadius.circular(14)
                                                  ) ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                        SizedBox(width: 20,),
                                                        //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                                                
                                                            hint: Text("Country",style: TextStyle(color: Colors.white),),
                                                            value: selectedCountry,
                                                            onChanged: (String? newValue){
                                                               setState(() {
                                                                   selectedCountry=newValue;
                                                               });
                                                            },
                                                            items:country.map((e)=>DropdownMenuItem<String>(
                                                              value: e,
                                                              child: Text(e,style: TextStyle(color: Colors.grey.shade800),))).toList() 
                                                              
                                                              ),
                                                        ),
                                                        
                                                     ],
                                                  ) ,
                                              ),
                                            ),
                                            SizedBox(width: 9,),
                                            Expanded(child: CustomTextField(
                                              enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffB74BFF)
                                        ),
                             
                                      ),
                                      inputHint:"Pin Code" ,
                                            ))
                                        ],
                                    ),

                                    SizedBox(height: 10,),


                                   Row(
                                      children: [
                                          Expanded(
                                            child: CustomTextField(
                                                                                  controller: date1,
                                                                                    readOnly: true,
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                            color: Color(0xffB74BFF)
                                                                                    ),
                                                                   
                                                                                  ),
                                                                                  inputHint:"Start Date" ,
                                                                                  suffixIcon: InkWell(
                                                                                    onTap: (){
                                            
                                            _selectDate(context);
                                            
                                                                                    },
                                            
                                                                                    child: Icon(Icons.date_range,color: Colors.white,)),
                                                                                ),
                                          ),
                                          SizedBox(width: 3,),
                                     Expanded(
                                       child: CustomTextField(
                                        controller: date1,
                                          readOnly: true,
                                          enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xffB74BFF)
                                          ),
                                                                   
                                        ),
                                        inputHint:"Start Date" ,
                                        suffixIcon: InkWell(
                                          onTap: (){
                                       
                                            _selectDate(context);
                                       
                                          },
                                       
                                          child: Icon(Icons.date_range,color: Colors.white,)),
                                                                           ),
                                     )
                                      ],
                                   ),

                                   SizedBox(height: 10,),

                                   Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            Expanded(
                                              child: Container(
                                                 height: 50,
                                                 decoration: ShapeDecoration(
                                                  shape:RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,color: Color(0xffB74BFF)
                                                      ),
                                                      borderRadius: BorderRadius.circular(14)
                                                  ) ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                        SizedBox(width: 20,),
                                                        //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                                                
                                                            hint: Text("Country",style: TextStyle(color: Colors.white),),
                                                            value: selectedCountry,
                                                            onChanged: (String? newValue){
                                                               setState(() {
                                                                   selectedCountry=newValue;
                                                               });
                                                            },
                                                            items:country.map((e)=>DropdownMenuItem<String>(
                                                              value: e,
                                                              child: Text(e,style: TextStyle(color: Colors.grey.shade800),))).toList() 
                                                              
                                                              ),
                                                        ),
                                                        
                                                     ],
                                                  ) ,
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                              Expanded(
                                                child: Container(
                                                 height: 50,
                                                 decoration: ShapeDecoration(
                                                  shape:RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 1,color: Color(0xffB74BFF)
                                                      ),
                                                      borderRadius: BorderRadius.circular(14)
                                                  ) ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                        SizedBox(width: 20,),
                                                        //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                                        DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                                                  
                                                            hint: Text("Country",style: TextStyle(color: Colors.white),),
                                                            value: selectedCountry,
                                                            onChanged: (String? newValue){
                                                               setState(() {
                                                                   selectedCountry=newValue;
                                                               });
                                                            },
                                                            items:country.map((e)=>DropdownMenuItem<String>(
                                                              value: e,
                                                              child: Text(e,style: TextStyle(color: Colors.grey.shade800),))).toList() 
                                                              
                                                              ),
                                                        ),
                                                        
                                                     ],
                                                  ) ,
                                                                                          ),
                                              )
                                        ]  
                                   ),

                                   SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                                                                
                                                                                  readOnly: true,
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                          color: Color(0xffB74BFF)
                                                                                  ),
                                                                 
                                                                                ),
                                                                                inputHint:"Upload Image" ,
                                                                                suffixIcon: InkWell(
                                                                                  onTap: (){
                                          
                                                                                      
                                          
                                                                                  },
                                          
                                                                                  child: Icon(Icons.upload_file,color: Colors.white,)),
                                                                              ),
                                        ),

                                                                            Expanded(
                                                                              child: Column(
                                                                                 children: [
                                                                                      Row(
                                                                                         children: [
                                                                                            Checkbox(value:check1 , onChanged:(value1) {
                                                                                                setState(() {
                                                                                                  check1=value1!;
                                                                                                });
                                                                                            },),
                                                                                            SizedBox(width: 3,),
                                                                                            Text("is Free Entry Allow ?",style: TextStyle(color: Colors.white,fontSize: 9),)
                                                                                         ],
                                                                                      ),
                                                                                      
                                                                                       Row(
                                                                                         children: [
                                                                                            Checkbox(value:check2 , onChanged:(value2) {
                                                                                                setState(() {
                                                                                                  check2=value2!;
                                                                                                });
                                                                                            },),
                                                                                            SizedBox(width: 3,),
                                                                                            Text("is Booking System Present ?",style: TextStyle(color: Colors.white,fontSize: 9),)
                                                                                         ],
                                                                                      ),
                                                                                    
                                                                                 ],
                                                                              ),
                                                                            )
                                      ],
                                    ),

                                     SizedBox(height: 7,),
                                    CommonButton(
                                      buttonText:"Submit",
                                    )
                                    
                                ],
                             ),
                           ),
                         ),
                         Text("Hii")
                     ]))
                     
                 ],
             ),
           ),
         ),
    
    );

          

  }
     
      Future<void> _selectDate(BuildContext context) async {
    DateTime? currentDate=await showDatePicker(
      context:context ,
      initialDate:selectedDate ,
     firstDate:DateTime(2000), 
     lastDate: DateTime(2100),
     );
     if(currentDate!=null&&currentDate!=selectedDate){
        setState(() {
           
           
            
        });
     }
}

 
}


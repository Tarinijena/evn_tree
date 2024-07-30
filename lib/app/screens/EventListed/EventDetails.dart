import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventDetailsImage.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListedData.dart';
import 'package:national_wild_animal/app/screens/EventListed/Model.dart';

class EventDetails extends StatelessWidget {
  final EventModel eventData;
  const EventDetails({super.key,required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF231D32),
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
               children: [
            
                Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height/3,
                   decoration: BoxDecoration(
                       image: DecorationImage(image: AssetImage("assets/adivasi3.jpeg"),fit: BoxFit.cover),
                       borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50)
                       )
                   ),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 15),
                     child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                           Column(
                            
                              children: [
                                  IconButton(onPressed: () {

                                    Navigator.pop(context);
                                    
                                  }, icon:Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,size: 30,))
                              ],
                           ),

                           Column(
                             children: [
                                Text(eventData.event.toLowerCase(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
                           Text(eventData.date+" "+eventData.month,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                           SizedBox(height: 20,)
                             ],
                           )
                       ],
                     ),
                   ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Row(
                           children: [
                               Icon(Icons.group,color: Colors.white,),
                        SizedBox(width:15,),
                        Text("18.4k Followers",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),)
                           ],
                        ),
                        CommonButton(
                          buttonText: "Follow",
                          height: 40,
                          width:90 ,
                          
                          
                          
                        )
                    ],
                  ),
                          
                    SizedBox(height: 60,),
                    Row(
                      children: [
                          Expanded(child: CommonButton(
                              buttonText: "Music Style",
                          )),
                          SizedBox(width: 10,),
                          Expanded(child: CommonButton(
                             buttonText: "Environment"
                          )),
                          SizedBox(width: 10,),
                          Expanded(child: CommonButton(
                            buttonText: "Artist"
                          ))
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text("Description",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(height: 15,),
                    Text("Adivasi is the collective term for the tribes of the Indian subcontinent, who are claimed to be the indigenous people of India prior to the Dravidians and Indo-Aryans. It refers to any of various ethnic groups considered to be the original inhabitants of the Indian subcontinent",style: TextStyle(fontSize: 14,color: Colors.white70),)
                    ],
                  ),
                ),
            
                SizedBox(height: 30,),
            
                Column(
                   children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //height: 100,
                        decoration: BoxDecoration(
                           color: Color.fromARGB(255, 18, 17, 18)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Text("Upcomeing Event",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                                SizedBox(height: 20,),
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: image.length,
                                    itemBuilder: (context, index) {
                                  
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 80,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image:DecorationImage(image: NetworkImage(image[index].imageUrl!),fit: BoxFit.cover)
                                          ),
                                        ),
                                      );
                                    
                                  },),
                                ),
            
                                SizedBox(height: 25,)
            
                             ],
                          ),
                        ),
                      )
                   ],
                ),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      Stack(
                        children: [
                           Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(70),
                               color: Colors.black
                            ),
                           ),
                           Container(
                         height: 30,
                         width: 30,
                         child: Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/128/733/733585.png"),fit: BoxFit.cover,)),
                      
                
                        ],
                        alignment: Alignment.center,
                      ),
                      SizedBox(width: 15,),
                      Stack(
                        children: [
                           Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(70),
                               color: Colors.black
                            ),
                           ),
                           Container(
                         height: 30,
                         width: 30,
                         child: Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/128/174/174883.png"),fit: BoxFit.cover,)),
                      
                
                        ],
                        alignment: Alignment.center,
                      ),
                      SizedBox(width: 15,),
                      Stack(
                        children: [
                           Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(70),
                               color: Colors.black
                            ),
                           ),
                           Container(
                         height: 30,
                         width: 30,
                         child: Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/128/2111/2111463.png"),fit: BoxFit.cover,)),
                      
                
                        ],
                        alignment: Alignment.center,
                      )
                   ],
                ),
                SizedBox(height: 15,)
                     
               ],
            ),
          ),
        ) ,
    );
  }
}
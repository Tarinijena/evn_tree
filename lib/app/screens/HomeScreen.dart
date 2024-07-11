import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/screens/HomeWidget/CustomAppBar.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF231D32),
           body: SafeArea(
             child: DefaultTabController(
              length: 2,
               child: Column(
                   children: [
                       CustomAppBar(),
                       SizedBox(height: 20,),
                       
                        Container(
                        height: 33,
                        decoration: BoxDecoration(
                          //color: Colors.transparent
                        ),
                         
                         child: TabBar(
                          
                           physics: ClampingScrollPhysics(),
                           
                           unselectedLabelColor: Color(0xffB74BFF),
                           indicatorSize: TabBarIndicatorSize.label,
                         
                           /*indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xffB74BFF),
                              border: Border(
                                bottom: BorderSide(color: Colors.transparent)
                              )
                           ),*/
                           //ehi properties ra use kari ame tab bar ru bottom line
                           //ku remove karipariba
                           dividerColor: Colors.transparent,
                     
      indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Color(0xffB74BFF),

      border: Border(
        bottom: BorderSide(color: Colors.transparent),
      ),
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
                       SizedBox(height: 10,),
                       Container(
                        height: MediaQuery.of(context).size.width,
                         child: TabBarView(children: [
                          
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                   return Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(13),
                                          color: Colors.amber,
                                            border:Border.all(
                                              width: 3,
                                              color: Colors.red,
                                            )
                                        ),
                                   );
                              },),
                            ),
                            Text("Hello")
                         ]),
                       )
               
                      
                      
                       
                   ],
               ),
             ),
           ),
    );
  }
}
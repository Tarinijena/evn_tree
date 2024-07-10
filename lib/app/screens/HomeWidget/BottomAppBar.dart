import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/screens/EventScreen.dart';
import 'package:national_wild_animal/app/screens/HomeScreen.dart';
import 'package:national_wild_animal/app/screens/profile_screen.dart';

class BottomAppBarPage extends StatefulWidget {

  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {

   int currentIndex=0;

   List screens=[
              

              
              HomeScreen(),
              EventScreen(),
              ProfileScreen()
              
              

           ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: BottomAppBar(
            height: 60,

            color: Color(0xFF2A233D),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  Row(
                     children: [

                         Container(
                          height: 50,
                          
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF231D32)
                          ),
                          child: IconButton(
                            isSelected: true,
                            onPressed:(){

                               setState(() {
                                  currentIndex=0;
                               });

                          } , icon:Icon(Icons.home,size: 20,color: Colors.white,))),
                          Container(
                             height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF231D32)
                          ),
                            child: IconButton(
                              
                              onPressed:(){
                                setState(() {
                                    currentIndex=1;
                                });
                            } 
                            , icon:Icon(Icons.theater_comedy_outlined,size: 20,color: Colors.white,)))
                        
                     ],
                  ),

                  Container(
                     height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF231D32)
                          ),
                    child: IconButton(
                     
                      onPressed:(){
                        setState(() {
                            currentIndex=2;
                        });
                    } , icon:Icon(Icons.person,size: 20,color: Colors.white,)))

               ],
            ),
        ),

        body: screens[currentIndex],
       
    );
  }
}
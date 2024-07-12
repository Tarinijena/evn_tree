
import 'package:flutter/material.dart';

class Profilepagedata{

  final String imagePath;
  
  final String festival;
  final String festivalLocation;
  final String festivalDate;


  Profilepagedata({
     required this.imagePath,
     
     required this.festival,
     required this.festivalLocation,
     required this.festivalDate,
     
  });


}

List<Profilepagedata> festivalData=[

   Profilepagedata(
      
      imagePath: 'assets/adivasi.jpeg',
      festival:"Festival", 
      festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
      festivalDate:"27 jan 2024-09 feb 2024",),
      
      

        Profilepagedata(

        imagePath: 'assets/adivasi1.jpeg',
        festival:"Festival", 
        festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
        festivalDate:"27 jan 2024-09 feb 2024",),
      
        
        

        Profilepagedata(
          imagePath: 'assets/adivasi2.jpeg',
          festival:"Festival", 
         festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
         festivalDate:"27 jan 2024-09 feb 2024",
        ),

        
        Profilepagedata(
          imagePath: 'assets/adivasi3.jpeg',
          festival:"Festival", 
         festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
         festivalDate:"27 jan 2024-09 feb 2024",
        ),
        
        Profilepagedata(
          imagePath: 'assets/adivasi4.jpeg',
          festival:"Festival", 
         festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
         festivalDate:"27 jan 2024-09 feb 2024",
        )
];
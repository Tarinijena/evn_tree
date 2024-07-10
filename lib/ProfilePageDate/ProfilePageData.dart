
import 'package:flutter/material.dart';

class Profilepagedata{

  final String imagePath;
  
  final String festival;
  final String festivalLocation;
  final String festivalDate;
  final Icon locationIcon;
  final Icon dateIcon;

  Profilepagedata({
     required this.imagePath,
     
     required this.festival,
     required this.festivalLocation,
     required this.festivalDate,
     required this.locationIcon,
     required this.dateIcon,
  });


}

List<Profilepagedata> festivalData=[

   Profilepagedata(
      
      imagePath: "assets/adivasi.jpg",
      festival:"Festival", 
      festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
      festivalDate:"27 jan 2024-09 feb 2024",
      locationIcon:Icon(Icons.location_city),
      dateIcon:Icon(Icons.date_range)),

        Profilepagedata(

        imagePath: "assets/adivasi1.jpg",
        festival:"Festival", 
        festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
        festivalDate:"27 jan 2024-09 feb 2024",
        locationIcon:Icon(Icons.location_city),
        dateIcon:Icon(Icons.date_range)
        
        ),

        Profilepagedata(
          imagePath: "assets/adivasi2.jpg",
          festival:"Festival", 
         festivalLocation:"Janata maidan,Jaydev vihar,Bbsr",
         festivalDate:"27 jan 2024-09 feb 2024",
         locationIcon:Icon(Icons.location_city),
         dateIcon:Icon(Icons.date_range))
];
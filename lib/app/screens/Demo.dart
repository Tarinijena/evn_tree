import 'package:flutter/material.dart';
import 'package:national_wild_animal/Model/Festival.dart';

class FestivalList extends StatefulWidget {
  const FestivalList({super.key});

  @override
  State<FestivalList> createState() => _FestivalListState();
}

class _FestivalListState extends State<FestivalList> {

  final List<String> category=['festival1','festival2','festival3','festival4'];

  final List<String> selectedCategories=[];

  @override
  Widget build(BuildContext context) {

     final filterFestival=festival.where((festival) {
           return selectedCategories.isEmpty ||selectedCategories.contains(festival.name);
     },).toList();

    return Scaffold(

     

      body: Column(
        
         children: [
               Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: category.map((e) => FilterChip(label: Text(e), 
                     selected:selectedCategories.contains(e),
                     onSelected:(selected){
                         setState(() {
                           if(selected){
                            selectedCategories.add(e);
                         }
                         else{
                            selectedCategories.remove(e);
                         }
                         });
                     }
                     
                     ),).toList() 
                  ),
               ),

               Expanded(
                child:ListView.builder(
                  itemCount:filterFestival.length,
                  itemBuilder:(context, index) {
                    final festival=filterFestival[index];
                    return Card(
                        elevation: 8.0,
                        margin: EdgeInsets.all(8.0),
                        child: Container(
                           decoration: BoxDecoration(
                              color: Colors.indigoAccent
                           ),
                           child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              title: Text(festival.name,style: TextStyle(color: Colors.white),),
                              subtitle: Text(festival.date,style: TextStyle(color: Colors.white),),
                           ),
                        ),
                    );
                  
                },)
                ),

               
         ],
      ),
    );
  }
}
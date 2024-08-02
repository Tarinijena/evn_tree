import 'dart:async';

import 'package:flutter/material.dart';

class GetData extends StatefulWidget {
  const GetData({super.key});

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {

  List<String> data=["event","festival","google","chrome","makarasankranti"];
  int currentIndex = 0;
  Timer? timer;

   @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      setState(() {
        // Update the index and reset it if it exceeds the length of the list
        currentIndex = (currentIndex + 1) % data.length;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
       body: Center(
          
          child: Text(data[currentIndex],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          
       ),
    );
  }
}
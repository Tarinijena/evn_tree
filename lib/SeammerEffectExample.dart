
import 'dart:math';

import 'package:flutter/material.dart';

class SeammerEffect extends StatelessWidget {
  const SeammerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
              children: [
                  Container(
                     child: ListView.builder(
                      itemCount:10 ,
                      itemBuilder: (context, index) {
                        var indx=Random().nextInt(5);
                             return Container(
                                margin: EdgeInsets.all(10),
                                
                             );
                     },),
                  )
              ],
          ),
        ),
    );
  }
}
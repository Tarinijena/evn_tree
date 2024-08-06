import 'package:flutter/material.dart';

class OptTextField extends StatelessWidget {
  final TextEditingController controller;
  const OptTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextField(
          decoration: InputDecoration( border: OutlineInputBorder(borderSide: BorderSide.none),contentPadding: EdgeInsets.only(left: 2,right: 2,bottom: 2,top: 2)),
          // maxLength: 1,
          // cursorHeight: 30,
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 30, color: Colors.white),
          textAlign: TextAlign.center,

          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}

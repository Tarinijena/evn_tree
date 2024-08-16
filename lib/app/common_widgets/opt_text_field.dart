import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FocusNode? previousFocusNode;

  const OptTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.focusNode,
    this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: const Color(0xFF171224),
          border: Border.all(width: 1, color: Colors.white24),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.all(0),
             counterText: "", // This hides the counter text for maxLength
          ),
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: Colors.blue,
          
          cursorHeight: 30,
          style: TextStyle(fontSize: 23, color: Colors.white),
          textAlign: TextAlign.center,
          focusNode: focusNode,
           maxLength: 1, // Allows only one character to be entered
          maxLengthEnforcement: MaxLengthEnforcement.enforced, // Enforces maxLength
          
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && previousFocusNode != null) {
              previousFocusNode!.requestFocus();
            }
          },
        ),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController thirdController = TextEditingController();
  final TextEditingController fourthController = TextEditingController();

  final FocusNode firstFocusNode = FocusNode();
  final FocusNode secondFocusNode = FocusNode();
  final FocusNode thirdFocusNode = FocusNode();
  final FocusNode fourthFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptTextField(
              controller: firstController,
              keyboardType: TextInputType.number,
              focusNode: firstFocusNode,
            ),
            SizedBox(width: 10),
            OptTextField(
              controller: secondController,
              keyboardType: TextInputType.number,
              focusNode: secondFocusNode,
              previousFocusNode: firstFocusNode,
            ),
            SizedBox(width: 10),
            OptTextField(
              controller: thirdController,
              keyboardType: TextInputType.number,
              focusNode: thirdFocusNode,
              previousFocusNode: secondFocusNode,
            ),
            SizedBox(width: 10),
            OptTextField(
              controller: fourthController,
              keyboardType: TextInputType.number,
              focusNode: fourthFocusNode,
              previousFocusNode: thirdFocusNode,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: OtpScreen()));
}

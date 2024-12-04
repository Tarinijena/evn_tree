import 'package:flutter/material.dart';

class ShowSnackBar{
  static showError(BuildContext context,String? message){
    final snackBar = SnackBar(
      content:  Text(message??'Error'),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.black,
        onPressed: () {
          // Perform some action
          // Navigator.pop(context);
        },
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static showSuccess(BuildContext context,String? message){
    final snackBar = SnackBar(
      content:  Text(message??'Success'),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.black,
        onPressed: () {
          // Perform some action
          // Navigator.pop(context);
        },
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
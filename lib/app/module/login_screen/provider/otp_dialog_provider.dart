import 'package:flutter/cupertino.dart';

class OtpDialogProvider extends ChangeNotifier{
  bool invalidOtp = false;

  

  changeStatus({bool status = false}){
    invalidOtp = status;
    notifyListeners();
  }


}
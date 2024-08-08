
import 'package:flutter/material.dart';

class UserRoleProvider extends ChangeNotifier{
    
    String? roles="";
    
    setUserRole(String? userRole){
           roles=userRole;
           notifyListeners();
    }

}
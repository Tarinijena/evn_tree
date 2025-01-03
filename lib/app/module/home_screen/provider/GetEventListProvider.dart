import 'dart:async';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';

class EventListProvider with ChangeNotifier {
  List<Map<String, dynamic>> _eventList = [];

  List<Map<String, dynamic>> get eventList => _eventList;
  Future<bool> getEventListForApproval(String token,String base64Json) async {

    

    Completer<bool> completer = Completer<bool>();

    try {
      

      HttpMethodsDio().getMethodWithToken(
        api: ApiEndPoint.getEventListForApproval(base64Json),
        token: token,
        fun: (map, code) {
          if (code == 200 && map['data'] != null && map['data'].isNotEmpty) {
            _eventList = List<Map<String, dynamic>>.from(map['data']);
            print("================================>====>");
            print(map['data']);
            
        notifyListeners();
        return true; // No need to decode again
            
            
          } else {
             _eventList = [];
        //notifyListeners();
        return false; // Handle other scenarios
          }
        },
        
      );
    } catch (e) {
      debugPrint("Error fetching events: $e");
      _eventList = [];
      notifyListeners();
      return false;  // Complete with an error if something goes wrong
    }

    return completer.future;
  }


  
 
}

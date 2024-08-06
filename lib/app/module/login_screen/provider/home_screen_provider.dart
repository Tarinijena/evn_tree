import 'package:flutter/cupertino.dart';

class HomeScreenProvider extends ChangeNotifier{

  int currentIndex = 0;

  int selectedIndex = 0;

  changeIndex({int lstLength = 1}){
    currentIndex = (currentIndex + 1) % lstLength;
    notifyListeners();
  }

  changeSelectedIndex({int index = 0}){
    selectedIndex = index;
    notifyListeners();
  }

}
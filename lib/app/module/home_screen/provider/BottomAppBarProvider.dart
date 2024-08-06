import 'package:flutter/cupertino.dart';

class BottomAppBarProvider extends ChangeNotifier{
  int currentPageIndex = 0;

  changePageOnClick({int index = 0}){
    currentPageIndex = index;
    notifyListeners();
  }

}
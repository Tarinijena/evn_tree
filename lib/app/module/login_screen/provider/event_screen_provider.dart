import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/LocationModel/location_model.dart';



class EventScreenProvider extends ChangeNotifier{

  int currentIndex = 0;

  int selectedIndex = 0;

  Data? dropdownValue;

  List<Data> cityLst = [Data(cityCode: "0", cityId: "0", cityName: "Select City")];

  List<DataLstClass> categoryList = [
    DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
  ];

  setCityList({List<Data>? cityLstData ,Data? dropdownValueData}){
    cityLst = cityLstData??[];
    dropdownValue = dropdownValueData;
    notifyListeners();
  }

  setCategoryList({required List<DataLstClass> categoryListData}){
    categoryList = categoryListData??[];
    notifyListeners();
  }

  setDropDownVal({Data? val}){
    dropdownValue = val;
    notifyListeners();

  }

  changeIndex({int lstLength = 1}){
    currentIndex = (currentIndex + 1) % lstLength;
    notifyListeners();
  }

  changeSelectedIndex({int index = 0}){
    selectedIndex = index;
    notifyListeners();
  }

}
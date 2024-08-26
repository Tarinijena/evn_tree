import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/country_api_services.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';

import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/module/home_screen/LocationModel/location_model.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/home_screen_provider.dart';

import 'package:national_wild_animal/app/module/login_screen/provider/event_screen_provider.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListed.dart';

import 'package:national_wild_animal/app/common_widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../app_utils/utils.dart';
import '../../common_widgets/CustomAppBar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: EventScreen(),
    );
  }
}

class _EventScreenState extends State<EventScreen> {
  bool check1 = false;
  bool check2 = false;

  DateTime selectedDate = DateTime.now();

  TextEditingController dateController = TextEditingController();
  TextEditingController dateController2 = TextEditingController();

  //this controller for create event form field..........
  TextEditingController eventCreate = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController country1Controller = TextEditingController();
  final valueListenable = ValueNotifier<String?>(null);
  TextEditingController country2Controller = TextEditingController();
  TextEditingController country3Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController country4Controller = TextEditingController();
  TextEditingController country5Controller = TextEditingController();
  TextEditingController Controller = TextEditingController();

  List item = ["Create Event", "Event Listing"];

  List country = ["India", "Pakistan", "China", "Japan"];

  //final TextEditingController country1 = TextEditingController();
//final valueListenable = ValueNotifier<String?>(null);

  TextEditingController search1 = TextEditingController();
  TextEditingController search2 = TextEditingController();
  TextEditingController search3 = TextEditingController();
  TextEditingController search4 = TextEditingController();
  TextEditingController search5 = TextEditingController();

  int current = 0;
  String? selectedCountry;

  SharedPref sharedPref = SharedPref();

  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 20);

      if (image == null) {
        Utils.disMissProgressIndicator();
        return;
      }
      // final imageTemporary = File(image.path);
      Utils.disMissProgressIndicator();
    } on PlatformException catch (e) {
      Utils.disMissProgressIndicator();
      if (kDebugMode) {
        print("Failed  to pick image: $e");
      }
    }
  }

  void showModalPop({bool profile = false, required BuildContext context}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  Utils.showProgressIndicator();
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop;
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  Utils.showProgressIndicator();
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop;
                },
                child: const Text('Upload from files'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
        });
  }

  Future<bool> getCityLst() async {
    Completer<bool> completer = Completer<bool>();

    List<Data> cityDatTemp = [];
    Data? dropDownValTemp;
    try {
      String data = await sharedPref.getKey("token");
      String token = json.decode(data);
      HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.citiesUrl,
          fun: (map, code) {
            if (code == 200 &&
                map is Map &&
                map['data'] != null &&
                map["data"].length > 0) {
              GetLocationModel citiesName =
                  GetLocationModel.fromJson(map as Map<String, dynamic>);
              cityDatTemp = citiesName.data ?? [];
              dropDownValTemp = cityDatTemp[0];
            } else {
              // dropDownValTemp = cityDatTemp[0];
            }
            context.read<HomeScreenProvider>().setCityList(
                cityLstData: cityDatTemp, dropdownValueData: dropDownValTemp);
            completer.complete(true);
          },
          token: token);
    } catch (e) {
      context.read<HomeScreenProvider>().setCityList(
          cityLstData: cityDatTemp, dropdownValueData: dropDownValTemp);
      completer.complete(false);
    }
    return completer.future;
  }

  //this is for country api integration..........................
  final CountryApiServices apiService = CountryApiServices();
  String? selectedCountry1;
  String? selectedCountry2;
  String? selectedCountry3;
  String? selectedCountry4;
  String? selectedCountry5;
  List<String> countries = [];

  Future<void> fetchCountries() async {
    try {
      List<String> fetchedCountries = await apiService.fetchCountries();
      setState(() {
        countries = fetchedCountries;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    getCityLst();
    super.initState();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<HomeScreenProvider>(
                builder: (context, provider, child) {
                  return CustomAppBar(
                    cityLst: context.read<HomeScreenProvider>().cityLst,
                    dropdownValue:
                        context.read<HomeScreenProvider>().dropdownValue,
                    onChange: (Data? val) {
                      context
                          .read<HomeScreenProvider>()
                          .setDropDownVal(val: val);
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 33,
                decoration: BoxDecoration(color: Colors.transparent),
                child: TabBar(
                    physics: ClampingScrollPhysics(),
                    unselectedLabelColor: Color(0xffB74BFF),
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffB74BFF),
                        border: Border(
                            bottom: BorderSide(color: Colors.transparent))),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 33,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xffB74BFF), width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Create Event",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 33,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xffB74BFF), width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Event Listed",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              Expanded(
                  child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23, top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Event Name",
                          controller: eventCreate,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Address Line 1",
                          controller: addressController,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Landmark",
                          controller: landmarkController,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          width:
                              double.infinity, // or any specific width you need
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xffB74BFF)),
                                          borderRadius:
                                              BorderRadius.circular(14))),
                                  child: Consumer<HomeScreenProvider>(
                                    builder: (context, provider, child) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton2<Data>(
                                          isExpanded: true,
                                          hint: Text(
                                            "Cities",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: context
                                              .read<HomeScreenProvider>()
                                              .dropdownValue2,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          dropdownStyleData: DropdownStyleData(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: ColorsGroup.iconColor,
                                              ),
                                              maxHeight: 150,
                                              offset: const Offset(0, 0),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                      radius:
                                                          const Radius.circular(
                                                              40),
                                                      thickness:
                                                          WidgetStateProperty
                                                              .all<double>(8),
                                                      thumbVisibility:
                                                          WidgetStateProperty
                                                              .all<bool>(true)),
                                              scrollPadding: EdgeInsets.all(3)),
                                          items: context
                                              .read<HomeScreenProvider>()
                                              .cityLst
                                              .map<DropdownMenuItem<Data>>(
                                                  (Data value) {
                                            return DropdownMenuItem<Data>(
                                              value: value,
                                              child: Text(value.cityName ?? ""),
                                            );
                                          }).toList(),
                                          onChanged: (Data? newValue) {
                                            context
                                                .read<HomeScreenProvider>()
                                                .setDropDownVal2(val: newValue);
                                          },
                                          onMenuStateChange: (bool sta) {
                                            debugPrint(">>>>>>>>>>>>>>$sta");
                                            if (sta) {
                                              country1Controller.text = "";
                                            }
                                          },
                                          dropdownSearchData:
                                              DropdownSearchData(
                                            searchController: search4,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Container(
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                expands: true,
                                                maxLines: null,
                                                controller: country1Controller,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText: 'Search ...',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              print('City Name: ${item.value?.cityName}, Search Value: $searchValue');
                                              return item.value!.cityName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue
                                                      .toString()
                                                      .toLowerCase());
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              /* Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xffB74BFF)),
                                          borderRadius: BorderRadius.circular(14))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: selectedCountry2,
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: ColorsGroup.iconColor,
                                          ),
                                          maxHeight: 150,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: WidgetStateProperty.all<double>(8),
                                              thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                          scrollPadding: EdgeInsets.all(3)),
                                      items: countries
                                          .map((String country) => DropdownMenuItem<String>(
                                              value: country,
                                              child: Text(
                                                country,
                                                style: TextStyle(color: Colors.white),
                                              )))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountry2 = newValue;
                                        });
                                      },
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: search2,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: country2Controller,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue.toString().toLowerCase());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),*/
                              Expanded(
                                  child: CustomTextField(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffB74BFF)),
                                ),
                                inputHint: "Pin Code",
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: Color(0xffB74BFF)),
                                  borderRadius:
                                      BorderRadius.circular(14))),
                          child: Consumer<HomeScreenProvider>(
                            builder: (context, provider, child) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton2<Data>(
                                  isExpanded: true,
                                  hint: Text(
                                    "Cities",
                                    style:
                                        TextStyle(color: Colors.white),
                                  ),
                                  value: context
                                      .read<HomeScreenProvider>()
                                      .dropdownValue2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        color: ColorsGroup.iconColor,
                                      ),
                                      maxHeight: 150,
                                      offset: const Offset(0, 0),
                                      scrollbarTheme:
                                          ScrollbarThemeData(
                                              radius:
                                                  const Radius.circular(
                                                      40),
                                              thickness:
                                                  WidgetStateProperty
                                                      .all<double>(8),
                                              thumbVisibility:
                                                  WidgetStateProperty
                                                      .all<bool>(true)),
                                      scrollPadding: EdgeInsets.all(3)),
                                  items: context
                                      .read<HomeScreenProvider>()
                                      .cityLst
                                      .map<DropdownMenuItem<Data>>(
                                          (Data value) {
                                    return DropdownMenuItem<Data>(
                                      value: value,
                                      child: Text(value.cityName ?? ""),
                                    );
                                  }).toList(),
                                  onChanged: (Data? newValue) {
                                    context
                                        .read<HomeScreenProvider>()
                                        .setDropDownVal2(val: newValue);
                                  },
                                  onMenuStateChange: (bool sta) {
                                    debugPrint(">>>>>>>>>>>>>>$sta");
                                    if (sta) {
                                      country1Controller.text = "";
                                    }
                                  },
                                  dropdownSearchData:
                                      DropdownSearchData(
                                    searchController: search4,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        controller: country2Controller,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets
                                                  .symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search ...',
                                          hintStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      print('City Name: ${item.value?.cityName}, Search Value: $searchValue');
                                      return item.value!.cityName
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchValue
                                              .toString()
                                              .toLowerCase());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                              SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: dateController,
                                readOnly: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffB74BFF)),
                                ),
                                inputHint: "Start Date",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      _selectDate();
                                    },
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: CustomTextField(
                                focusedBorder: OutlineInputBorder(),
                                controller: dateController2,
                                readOnly: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffB74BFF)),
                                ),
                                inputHint: "End Date",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      _selectDate();
                                    },
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /*Container(
                          width: double.infinity, // or any specific width you need
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xffB74BFF)),
                                          borderRadius: BorderRadius.circular(14))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: selectedCountry4,
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: ColorsGroup.iconColor,
                                          ),
                                          maxHeight: 150,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: WidgetStateProperty.all<double>(8),
                                              thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                          scrollPadding: EdgeInsets.all(3)),
                                      items: countries
                                          .map((String country) => DropdownMenuItem<String>(
                                              value: country,
                                              child: Text(
                                                country,
                                                style: TextStyle(color: Colors.white),
                                              )))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountry4 = newValue;
                                        });
                                      },
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: search4,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: country4Controller,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue.toString().toLowerCase());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xffB74BFF)),
                                          borderRadius: BorderRadius.circular(14))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: selectedCountry5,
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: ColorsGroup.iconColor,
                                          ),
                                          maxHeight: 150,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: WidgetStateProperty.all<double>(8),
                                              thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                          scrollPadding: EdgeInsets.all(3)),
                                      items: countries
                                          .map((String country) => DropdownMenuItem<String>(
                                              value: country,
                                              child: Text(
                                                country,
                                                style: TextStyle(color: Colors.white),
                                              )))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountry5 = newValue;
                                        });
                                      },
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: search5,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: country5Controller,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue.toString().toLowerCase());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showModalPop(context: context);
                                },
                                child: CustomTextField(
                                  enable: false,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffB74BFF)),
                                  ),
                                  inputHint: "Upload Image",
                                  suffixIcon: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.upload_file,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: check1,
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: -4),
                                        onChanged: (value1) {
                                          setState(() {
                                            check1 = value1!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "is Free Entry Allow ?",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9),
                                        maxLines: 2,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: check2,
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: -4),
                                        onChanged: (value2) {
                                          setState(() {
                                            check2 = value2!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.26,
                                        child: Text(
                                          "is Booking System Present ?",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 9),
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        CommonButton(
                          buttonText: "Submit",
                          width: double.infinity,
                        )
                      ],
                    ),
                  ),
                ),
                //Text("Hii",style: TextStyle(color: Colors.white),)
                EventListedPage()
              ]))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? currentDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (currentDate != null && currentDate != selectedDate) {
      setState(() {
        dateController.text = currentDate.toString().split(" ")[0];
      });
    }
  }
}

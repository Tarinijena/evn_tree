import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListed.dart';

import 'package:national_wild_animal/app/common_widgets/custom_text_field.dart';
import 'package:national_wild_animal/app/screens/profile_screen.dart';

import '../../app_utils/utils.dart';

class EventScreen extends StatefulWidget {
  EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool check1 = false;
  bool check2 = false;

  DateTime selectedDate = DateTime.now();

  TextEditingController dateController = TextEditingController();
  TextEditingController dateController2 = TextEditingController();

  List item = ["Create Event", "Event Listing"];

  List country = ["India", "Pakistan", "China", "Japan"];

  int current = 0;
  String? selectedCountry;

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
              CustomAppBar(),
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
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Address Line 1",
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Landmark",
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xffB74BFF)),
                                        borderRadius:
                                            BorderRadius.circular(14))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          hint: Text(
                                            "Country",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: selectedCountry,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedCountry = newValue;
                                            });
                                          },
                                          items: country
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800),
                                                      )))
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xffB74BFF)),
                                        borderRadius:
                                            BorderRadius.circular(14))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          hint: Text(
                                            "Country",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: selectedCountry,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedCountry = newValue;
                                            });
                                          },
                                          items: country
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800),
                                                      )))
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xffB74BFF)),
                                        borderRadius:
                                            BorderRadius.circular(14))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          hint: Text(
                                            "Country",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: selectedCountry,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedCountry = newValue;
                                            });
                                          },
                                          items: country
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800),
                                                      )))
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 9,
                            ),
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
                        SizedBox(
                          height: 10,
                        ),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xffB74BFF)),
                                          borderRadius:
                                              BorderRadius.circular(14))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                            hint: Text(
                                              "Country",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: selectedCountry,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedCountry = newValue;
                                              });
                                            },
                                            items: country
                                                .map((e) =>
                                                    DropdownMenuItem<String>(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade800),
                                                        )))
                                                .toList()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xffB74BFF)),
                                          borderRadius:
                                              BorderRadius.circular(14))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      //Text("Country",style: TextStyle(fontSize: 20,color: Colors.white),),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                            hint: Text(
                                              "Country",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: selectedCountry,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedCountry = newValue;
                                              });
                                            },
                                            items: country
                                                .map((e) =>
                                                    DropdownMenuItem<String>(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade800),
                                                        )))
                                                .toList()),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
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

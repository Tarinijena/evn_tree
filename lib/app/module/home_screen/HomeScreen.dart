import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:national_wild_animal/ProfilePageDate/ProfilePageData.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';
import 'package:national_wild_animal/app/app_theme/text_styles.dart';
import 'package:national_wild_animal/app/common_widgets/common_text_field_view.dart';
import 'package:national_wild_animal/app/common_widgets/CustomAppBar.dart';
import 'package:national_wild_animal/app/module/home_screen/LocationModel/location_model.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../../app_utils/shared_preferance.dart';
import 'provider/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: HomeScreen(),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  //bool isSelected=false;

  double maxScrollExtent = 0.0;
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  List<RotateAnimatedText> data = [
    RotateAnimatedText("event"),
    RotateAnimatedText("festival"),
    RotateAnimatedText("google"),
    RotateAnimatedText("chrome"),
    RotateAnimatedText("makarasankranti")
  ];
  Timer? timer;

  SharedPref sharedPref = SharedPref();

  Future<bool> getCategoryList() async {
    Completer<bool> completer = Completer<bool>();
    List<DataLstClass> categoryListTemp = [];
    try {
      String data = await sharedPref.getKey("token");
      String token = json.decode(data);

      HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.categoryLst,
          fun: (map, code) {
            if (code == 200 && map['data'] != null && map['data'].length > 0) {
              context.read<HomeScreenProvider>().categoryList.clear();

              map['data'].forEach((e) {
                categoryListTemp.add(DataLstClass(
                    nameStr: e['categoryName'], icon: Icons.category_outlined));
              });
              categoryListTemp.insert(
                0,
                DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
              );
              context
                  .read<HomeScreenProvider>()
                  .setCategoryList(categoryListData: categoryListTemp);
            } else {
              categoryListTemp = [
                DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
              ];
              context
                  .read<HomeScreenProvider>()
                  .setCategoryList(categoryListData: categoryListTemp);
            }
            completer.complete(true);
          },
          token: token);
    } catch (e) {
      categoryListTemp = [
        DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
      ];
      context
          .read<HomeScreenProvider>()
          .setCategoryList(categoryListData: categoryListTemp);
      completer.complete(false);
    }
    return completer.future;
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
              /*cityDatTemp = [
                Data(cityCode: "0", cityId: "0", cityName: "Select City")
              ];*/
              //dropDownValTemp = cityDatTemp[0];
            }
            context.read<HomeScreenProvider>().setCityList(
                cityLstData: cityDatTemp, dropdownValueData: dropDownValTemp);
            completer.complete(true);
          },
          token: token);
    } catch (e) {
      cityDatTemp = [Data(cityCode: "0", cityId: "0", cityName: "Select City")];
      dropDownValTemp = cityDatTemp[0];
      context.read<HomeScreenProvider>().setCityList(
          cityLstData: cityDatTemp, dropdownValueData: dropDownValTemp);
      completer.complete(false);
    }
    return completer.future;
  }

  @override
  void initState() {
    scrollController.addListener(() {
      maxScrollExtent = scrollController.position.maxScrollExtent;
    });

    callApi();

    super.initState();
  }

  String? fullName;
  callApi() async {
    await Future.wait([
      getCategoryList(),
      getCityLst(),
    ]);
    fullName = await sharedPref.getKey("fullName");
    if (fullName != null && fullName != "") {
      fullName = jsonDecode(fullName!);
    }
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, top: 12, right: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hello",
                            style: TextStyles(context)
                                .googleRubikFontsForButtonText(
                                    fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                          Text(" ${fullName ?? "-----"}",
                              style: TextStyles(context)
                                  .googleRubikFontsForText2(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)),
                          Text(",",
                              style: TextStyles(context)
                                  .googleRubikFontsForButtonText(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        height: 35,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "Let’s explore your fav ",
                                style: TextStyles(context)
                                    .googleRubikFontsForButtonText(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                              ),
                              SizedBox(
                                width: 500,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DefaultTextStyle(
                                    style: TextStyles(context)
                                        .googleRubikFontsForText2(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                    child: AnimatedTextKit(
                                      animatedTexts: data,
                                      isRepeatingAnimation: true,
                                      repeatForever: true,
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(" !",
                                  style: TextStyles(context)
                                      .googleRubikFontsForButtonText(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      CommonTextFieldView(
                        controller: textEditingController,
                        // errorText: _errorFName,
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        keyboardType: TextInputType.name,
                        onChanged: (String txt) {},
                        isAllowTopTitleView: false,
                        suffixIcon: Icons.search,
                        suffixIconColor: Colors.white,
                        suffixIconSize: 25,
                        radius: 15.5,
                        height: 35,
                        borderColor: const Color(0xFFC1C1C1),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Consumer<HomeScreenProvider>(
                        builder: (context, provider, child) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60,
                                width: size.width * 0.8,
                                child: ListView.builder(
                                    itemCount: context
                                        .read<HomeScreenProvider>()
                                        .categoryList
                                        .length,
                                    controller: scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<HomeScreenProvider>()
                                              .changeSelectedIndex(
                                                  index: index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 19.0),
                                          child: Column(
                                            children: [
                                              Consumer<HomeScreenProvider>(
                                                builder:
                                                    (context, provider, child) {
                                                  return Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color(
                                                                  0xFF362B51)),
                                                          color: (context
                                                                      .read<
                                                                          HomeScreenProvider>()
                                                                      .selectedIndex ==
                                                                  index)
                                                              ? const Color(
                                                                  0xFFB74BFF)
                                                              : const Color(
                                                                  0xFF221D31)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Icon(
                                                          context
                                                              .read<
                                                                  HomeScreenProvider>()
                                                              .categoryList[
                                                                  index]
                                                              .icon,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ));
                                                },
                                              ),
                                              Text(
                                                context
                                                        .read<
                                                            HomeScreenProvider>()
                                                        .categoryList[index]
                                                        .nameStr ??
                                                    "",
                                                style: TextStyles(context)
                                                    .googleRubikFontsForButtonText(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              (context
                                          .read<HomeScreenProvider>()
                                          .categoryList
                                          .length >
                                      4)
                                  ? GestureDetector(
                                      onTap: () {
                                        double currentOffset =
                                            scrollController.offset;
                                        double newOffset = currentOffset + 30.0;

                                        if (maxScrollExtent == 0) {
                                          scrollController.jumpTo(
                                            30,
                                          );
                                        }

                                        if (newOffset <= maxScrollExtent) {
                                          scrollController.animateTo(
                                            newOffset,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        } else {
                                          // If reached the end, stop scrolling further
                                          scrollController
                                              .jumpTo(maxScrollExtent);
                                        }
                                      },
                                      child: Container(
                                        color: const Color(0xFF362B51),
                                        height: 40,
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.arrow_forward_sharp,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          );
                        },
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 33,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: TabBar(
                                physics: ClampingScrollPhysics(),
                                unselectedLabelColor: Color(0xffB74BFF),
                                indicatorSize: TabBarIndicatorSize.label,
                                dividerColor: Colors.transparent,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xffB74BFF),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.transparent))),
                                tabs: [
                                  Tab(
                                    child: Container(
                                      height: 33,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Color(0xffB74BFF),
                                              width: 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Ungoing",
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Color(0xffB74BFF),
                                              width: 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Upcomeing",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: TabBarView(children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: festivalData.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            color: Color(0xFF2A233D)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 90,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            festivalData[index]
                                                                .imagePath,
                                                          ),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Adibasi Mela",
                                                    style: TextStyle(
                                                        color: ColorsGroup
                                                            .whiteColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xFFB74BFF),
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          festivalData[index]
                                                              .festivalLocation,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.date_range,
                                                        color:
                                                            Color(0xFFB74BFF),
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          festivalData[index]
                                                              .festivalLocation,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        height: 20,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey.shade800,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: Center(
                                                            child: Text(
                                                          festivalData[index]
                                                              .festival,
                                                          style: TextStyle(
                                                              color: ColorsGroup
                                                                  .whiteColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))),
                                                    SizedBox(
                                                      width: 8,
                                                    )
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      //isSelected=true;
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Text("Hii")
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

class DataLstClass {
  IconData? icon;
  String? nameStr;
  DataLstClass({this.icon, this.nameStr});
}

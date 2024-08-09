import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';
import 'package:national_wild_animal/app/module/home_screen/LocationModel/location_model.dart';

import '../app_utils/helper.dart';
import '../app_utils/shared_preferance.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with Helper {
  Data? dropdownValue;

  SharedPref sharedPref = SharedPref();
  getCityLst() async {
    try {
      String data = await sharedPref.getKey("token");
      String token = json.decode(data);
      HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.citiesUrl,
          fun: (map, code) {
            if (code == 200 && map is Map && map['data'] != null && map["data"].length > 0) {
              GetLocationModel citiesName = GetLocationModel.fromJson(map as Map<String, dynamic>);
              cityLst = citiesName.data ?? [];
              cityLst.insert(0, Data(cityCode: "0", cityId: "0", cityName: "Select City"));
              dropdownValue = cityLst[0];
            } else {
              cityLst = [Data(cityCode: "0", cityId: "0", cityName: "Select City")];
              dropdownValue = cityLst[0];
            }
            setState(() {

            });
          },
          token: token);
    } catch (e) {
      cityLst = [Data(cityCode: "0", cityId: "0", cityName: "Select City")];
      dropdownValue = cityLst[0];
      setState(() {

      });
    }
  }

  List<Data> cityLst = [Data(cityCode: "0", cityId: "0", cityName: "Select City")];
  final valueListenable = ValueNotifier<String?>(null);
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    getCityLst();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1), color: const Color(0xFF2A233D)),
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/logo1.png",
                  width: 30,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFF1F1734), borderRadius: BorderRadius.circular(8.5)),
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4, right: 2, left: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: ColorsGroup.iconColor,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<Data>(
                            value: dropdownValue,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            alignment: Alignment.centerLeft,
                            dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: ColorsGroup.iconColor,
                                ),
                                maxHeight: 150,
                                offset: const Offset(-20, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: WidgetStateProperty.all<double>(8),
                                    thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                scrollPadding: EdgeInsets.all(3)),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 8, right: 4),
                            ),
                            onChanged: (Data? value) {
                              setState(() {
                                dropdownValue = value;
                              });
                            },
                            iconStyleData: IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 25,
                              ),
                              iconEnabledColor: ColorsGroup.iconColor,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
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
                                  controller: textEditingController,
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
                                return item.value!.cityName
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchValue.toString().toLowerCase());
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },

                            items: cityLst.map<DropdownMenuItem<Data>>((Data value) {
                              return DropdownMenuItem<Data>(
                                value: value,
                                child: Text(value.cityName ?? ""),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /* SizedBox(
              height: 30,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 20,
                        color: ColorsGroup.iconColor,
                      )),
                  const Positioned(
                      left: 8,
                      right: 0,
                      top: -2,
                      child: Text(
                        "3",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )*/
            _buildIconButton(
              icon: Icons.logout,
              index: null,
              onPressed: gotoSplashScreen,
            ),
          ],
        ),
      ),
    );
  }

  void gotoSplashScreen() async {
    bool isOk = await showCommonPopupNew(
      "Are you sure?",
      "You want to Sign Out?",
      context,
      barrierDismissible: true,
      isYesOrNoPopup: true,
    );
    if (isOk) {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save("isLogIn", "false");

      Navigator.pushNamedAndRemoveUntil(
        context,
        "/splashScreen",
        (Route<dynamic> route) => false,
      );
    }
  }

  Widget _buildIconButton({required IconData icon, int? index, void Function()? onPressed}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF231D32),
      ),
      child: IconButton(
        onPressed: onPressed ?? () {},
        icon: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}

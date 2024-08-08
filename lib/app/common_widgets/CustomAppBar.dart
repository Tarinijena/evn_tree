import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';
import 'package:national_wild_animal/app/module/home_screen/LocationModel/location_model.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Data? dropdownValue;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          color: const Color(0xFF2A233D)),
      height: 41,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF1F1734),
                      borderRadius: BorderRadius.circular(8.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4, right: 35, left: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: ColorsGroup.iconColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton<Data>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: null,
                          alignment: Alignment.center,
                          onChanged: (Data ?value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                          items: <Data>[
                            Data(
                                cityCode:dropdownValue?.cityName, 
                                cityId: dropdownValue?.cityId,
                                cityName: dropdownValue?.cityName),
                            Data(
                                cityCode: "Bbsr2h",
                                cityId: "83a6d3e5-5f91-4c6b-b5c8-78b7b7fbc4f13",
                                cityName: "cuttack")
                          ].map<DropdownMenuItem<Data>>((Data value) {
                            return DropdownMenuItem<Data>(
                              value: value,
                              child: Text(value.cityName ?? ""),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
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
            )
          ],
        ),
      ),
    );
  }
}

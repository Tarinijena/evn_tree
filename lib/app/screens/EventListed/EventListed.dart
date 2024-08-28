import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/home_screen_provider.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventCard.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventDetails.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListedData.dart';
import 'package:provider/provider.dart';

class EventListedPage extends StatefulWidget {
  const EventListedPage({super.key});

  @override
  State<EventListedPage> createState() => _EventListedPageState();
}

class _EventListedPageState extends State<EventListedPage> {
  int isSelected = 0;

  List<String> event = ["All", "Music", "Food", "Tech", "Education"];

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: event.length,
              itemBuilder: (context, index) {
                return _buildProductCategory(index: index, name: event[index]);
              },
            ),
          ),
          Container(
            child: isSelected == 0
                ? _showAllEvent()
                : isSelected == 1
                    ? _showAllMusic()
                    : isSelected == 2
                        ? _showAllFood()
                        : isSelected == 3
                            ? _showAllTech()
                            : null,
          )
        ],
      ),
    );
  }

  _buildProductCategory({required int index, required String name}) => GestureDetector(
        onTap: () {
          setState(() {
            isSelected = index;
          });
        },
        child: Container(
          width: 100,
          height: 40,
          margin: EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isSelected == index ? Color(0xFFB74BFF) : Colors.grey.shade400, borderRadius: BorderRadius.circular(8)),
          child: Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected == index ? Colors.white : Colors.black),
          ),
        ),
      );

  //show all event list...................

  _showAllEvent() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: EventData.allEvent.length,
            itemBuilder: (context, index) {
              final allEvents = EventData.allEvent[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetails(eventData: allEvents),
                          ));
                    },
                    child: EventCard(model: allEvents)),
              );
            },
          ),
        ),
      );

  //show all music list...................

  _showAllMusic() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: EventData.allEvent.length,
            itemBuilder: (context, index) {
              final allMusic = EventData.music[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetails(eventData: allMusic),
                          ));
                    },
                    child: EventCard(model: allMusic)),
              );
            },
          ),
        ),
      );

  //show all food list...................

  _showAllFood() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: EventData.food.length,
            itemBuilder: (context, index) {
              final allFood = EventData.food[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetails(eventData: allFood),
                          ));
                    },
                    child: EventCard(model: allFood)),
              );
            },
          ),
        ),
      );

  //show all tech list...................

  _showAllTech() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: EventData.tech.length,
            itemBuilder: (context, index) {
              final allTech = EventData.tech[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetails(eventData: allTech),
                          ));
                    },
                    child: EventCard(model: allTech)),
              );
            },
          ),
        ),
      );
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/GetEventListProvider.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/home_screen_provider.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventCard.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventDescription.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListedData.dart';
import 'package:provider/provider.dart';

class EventListedPage extends StatefulWidget {

  const EventListedPage({super.key});

  @override
  State<EventListedPage> createState() => _EventListedPageState();
  static Widget builder(BuildContext context) {
    return /*ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: HomeScreen(),
    );*/
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) =>EventListProvider()),
      ],
      child:  HomeScreen(),
    );
  }
}

class _EventListedPageState extends State<EventListedPage> {

   late final eventList;

  int isSelected = 0;

  List<String> event = ["All", "Music", "Food", "Tech", "Education"];

   SharedPref sharedPref = SharedPref();
   
    late Future<bool> categoryFuture;

  @override
  void initState() {
    super.initState();
    _fetchEventList();
    // Fetch the category list on initialization
    categoryFuture = getCategoryList();
  }

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

   DataLstClass? categories;
  String? categoriesName;
  String? cities;

  Future<void> _fetchEventList() async {
     categories=context.read<HomeScreenProvider>().dropdownValue3;
    categoriesName=categories?.nameStr;
     cities=context.read<HomeScreenProvider>().dropdownValue2!.cityId;
     Map<String,dynamic> locationAndCategory={
"city":cities,
"category":categoriesName,
  "type": "ON_GOING",
  
  };
          String? jsonString;
        String? base64String;

        //Convert the Map to a JSON string
   jsonString = jsonEncode(locationAndCategory);

   //jsonString=createEventJson.toString as String?;

  // Convert the JSON string to Base64
  base64String = base64Encode(utf8.encode(jsonString));
    final token = await sharedPref.getKey("token"); // Retrieve token
    final provider = Provider.of<EventListProvider>(context, listen: false);
     await provider.getEventListForApproval(json.decode(token),base64String);}

  @override
  Widget build(BuildContext context) {

     return FutureBuilder<bool>(
      future: categoryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error loading categories"));
        }

        final categoryList = context.watch<HomeScreenProvider>().categoryList;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return _buildProductCategory(
                      index: index,
                      name: categoryList[index].nameStr ?? "Unknown",
                    );
                  },
                ),
              ),
              Container(
                child: isSelected == 0
                    ? _showAllEvent(context)
                    : isSelected == 1
                        ? _showAllMusic(context)
                        : isSelected == 2
                            ? _showAllFood(context)
                            : isSelected == 3
                                ? _showAllTech(context)
                                : null,
              )
            ],
          ),
        );
      },
    );
  }

  _buildProductCategory({required int index, required String name}) =>
      GestureDetector(
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
            color: isSelected == index
                ? Color(0xFFB74BFF)
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected == index ? Colors.white : Colors.black,
            ),
          ),
        ),
      );

  //show all event list...................

   _showAllEvent(BuildContext context) {
  return Consumer<EventListProvider>(
    builder: (context, eventListProvider, child) {
      final eventList = eventListProvider.eventList;

      if (eventList.isEmpty) {
        return Center(
          child: Text("No events available"),
        );
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final allEvents = eventList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetails(eventData: allEvents),
                      ),
                    );
                  },
                  child: EventCard(allEvent:allEvents),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}


  //show all music list...................

  _showAllMusic(BuildContext context) {
  return Consumer<EventListProvider>(
    builder: (context, eventListProvider, child) {
      final eventList = eventListProvider.eventList;

      if (eventList.isEmpty) {
        return Center(
          child: Text("No events available"),
        );
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final allEvents = eventList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetails(eventData: allEvents),
                      ),
                    );
                  },
                  child: EventCard(allEvent:allEvents),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

  //show all food list...................

 _showAllFood(BuildContext context) {
  return Consumer<EventListProvider>(
    builder: (context, eventListProvider, child) {
      final eventList = eventListProvider.eventList;

      if (eventList.isEmpty) {
        return Center(
          child: Text("No events available"),
        );
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final allEvents = eventList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetails(eventData: allEvents),
                      ),
                    );
                  },
                  child: EventCard(allEvent:allEvents),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

  //show all tech list...................

 _showAllTech(BuildContext context) {
  return Consumer<EventListProvider>(
    builder: (context, eventListProvider, child) {
      final eventList = eventListProvider.eventList;

      if (eventList.isEmpty) {
        return Center(
          child: Text("No events available"),
        );
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              final allEvents = eventList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetails(eventData: allEvents),
                      ),
                    );
                  },
                  child: EventCard(allEvent:allEvents),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}}
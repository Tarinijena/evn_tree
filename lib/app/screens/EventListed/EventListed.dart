import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventCard.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventDetails.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListedData.dart';

class EventListedPage extends StatefulWidget {
  const EventListedPage({super.key});

  @override
  State<EventListedPage> createState() => _EventListedPageState();
}

class _EventListedPageState extends State<EventListedPage> {
  int isSelected = 0;

  List<String> event = ["All", "Music", "Food", "Tech", "Education"];

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

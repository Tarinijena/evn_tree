import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/screens/EventListed/Model.dart';

class EventCard extends StatefulWidget {
  final EventModel model;

  EventCard({super.key, required this.model});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xFF2A233D), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xFFB74BFF)),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.model.date,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                widget.model.month,
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.event,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                widget.model.fees,
                style: TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.forward_sharp,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

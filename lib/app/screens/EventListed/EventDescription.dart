import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/common_widgets/event_des_time_btn.dart';
import 'package:national_wild_animal/app/common_widgets/event_description_add_activity.dart';
import 'package:national_wild_animal/app/screens/EventListed/Model.dart';

class EventDetails extends StatefulWidget {
  final EventModel eventData;
  const EventDetails({super.key, required this.eventData});
  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  int isSelected = 0;

  List<Item> _data = generateItems();

  List<String> date = [
    "10/11/2024",
    "11/11/2024",
    "12/11/2024",
    "13/11/2024",
    "14/11/2024"
  ];

  final TextEditingController activityController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _showDialog(BuildContext context) {
    // Example dialog to add activity
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventDescriptionAddActivity(
            activityController: activityController,
            startTimeController: startTimeController,
            endTimeController: endTimeController,
            artistController: artistController,
            descriptionController: descriptionController);
      },
    );
  }

  bool favouriteIconSeled = false;

  bool microphoneSelected=false;

  @override
  Widget build(BuildContext context) {
    print("Build method is executing.............");
    return Scaffold(
      backgroundColor: Color(0xFF231D32),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/adivasi3.jpeg"),
                      fit: BoxFit.cover),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Sample Event Title'.toLowerCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25),
                          ),
                          Text(
                            "10 November 2024",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 7,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 30),
                            SizedBox(width: 15),
                            Text(
                              "18.4k Loves",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              favouriteIconSeled = !favouriteIconSeled;
                            });
                          },
                          child: favouriteIconSeled
                              ? Icon(Icons.favorite,
                                  color: Colors.red, size: 30)
                              : Icon(Icons.favorite_outline,
                                  color: Colors.white, size: 30),
                        )
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade800),
                          onPressed: () {
                            _showDialog(context);
                          },
                          child: Text(
                            "Add Activity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: date.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = index;
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 20,
                          margin: EdgeInsets.only(top: 10, right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected == index
                                ? Colors.purple.shade500
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            date[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 7),
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DataTableTheme(
                    data: DataTableThemeData(
                       headingRowColor: WidgetStatePropertyAll(Colors.blue)
                    ),
                    child: DataTable(
                      border: TableBorder.all(
                        color: Colors.white
                      ),
                      columns: [
                        DataColumn(
                          
                          label: Text(
                            'Start Time',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'End Time',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Activity Name',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Artist',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Description',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    
                      rows: const [
                         /*DataRow(
                          
                          cells: [
                          DataCell(Text('Start Time',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('End Time',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Activity Name',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Artist',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Description',style: TextStyle(color: Colors.white),)),
                        ]),*/
                        DataRow(
                          
                          cells: [
                          DataCell(Text('10:00 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('11:00 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Painting',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('John Doe',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Painting workshop for beginners',style: TextStyle(color: Colors.white),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('11:30 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('12:30 PM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Music',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Jane Smith',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Live music performance',style: TextStyle(color: Colors.white),)),
                        ]),
                         DataRow(
                          
                          cells: [
                          DataCell(Text('10:00 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('11:00 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Painting',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('John Doe',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Painting workshop for beginners',style: TextStyle(color: Colors.white),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('11:30 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('12:30 PM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Music',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Jane Smith',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Live music performance',style: TextStyle(color: Colors.white),)),
                        ]),
                         DataRow(
                          
                          cells: [
                          DataCell(Text('10:00 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('11:00 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Painting',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('John Doe',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Painting workshop for beginners',style: TextStyle(color: Colors.white),)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('11:30 AM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('12:30 PM',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Music',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Jane Smith',style: TextStyle(color: Colors.white),)),
                          DataCell(Text('Live music performance',style: TextStyle(color: Colors.white),)),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),*/

              /*Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Melody Night",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),

                       InkWell(
                        onTap: () {
                           setState(() {
                             microphoneSelected = !microphoneSelected;
                           });
                        },
                        child:microphoneSelected? Image.asset(
                          "assets/microphone.png",height: 30,width: 30,color: Colors.red,):
                          Image.asset(
                          "assets/microphone.png",height: 30,width: 30,color: Colors.white,)
                        )
                        ,
                        
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          EventDeswcriptionTimeButton(
                            backgroundColor: Colors.red.shade400,
                            buttonText: "5.00 pm",
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          EventDeswcriptionTimeButton(
                            backgroundColor: Colors.purple,
                            buttonText: "5.00 pm",
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          "21 Nov 2024",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),

                      ],
                    ),
                  ],
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: ClipRRect(
                   borderRadius: BorderRadius.circular(14),
                   
                  child: ExpansionPanelList(
                    expandIconColor: Colors.white,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data[index].isExpanded = isExpanded;
                      });
                      
                    },
                    elevation: 3,
                    children: _data.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        
                        backgroundColor: Color(0xFF2A233D),
                                
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Padding(
                  padding: const EdgeInsets.only(left: 0,right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Melody Night",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                                
                         InkWell(
                          onTap: () {
                             setState(() {
                               microphoneSelected = !microphoneSelected;
                             });
                          },
                          child:microphoneSelected? Image.asset(
                            "assets/microphone.png",height: 25,width: 30,color: Colors.red,):
                            Image.asset(
                            "assets/microphone.png",height: 25,width: 30,color: Colors.white,)
                          )
                          ,
                          
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            EventDeswcriptionTimeButton(
                              backgroundColor: Colors.red.shade400,
                              buttonText: "5.00 pm",
                              textColor: Colors.white,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            EventDeswcriptionTimeButton(
                              backgroundColor: Colors.purple,
                              buttonText: "5.00 pm",
                              textColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "21 Nov 2024",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                                
                        ],
                      ),
                    ],
                  ),
                                ),
                            tileColor: Colors.transparent,
                          );
                        },
                        body: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Artist",style: TextStyle(color:  Colors.red,fontWeight: FontWeight.bold,fontSize: 20,)),
                              Text(
                                item.expandedValue,
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14,),
                              ),
                              Text("Description",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20,)),
                              Text(
                                "The man gave the police a detailed description of the burglar",
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14,),
                              ),
                            ],
                          ),
                          /*subtitle: Text(
                            'Click to collapse.',
                            style: TextStyle(color: Colors.grey),
                          ),*/
                          onTap: () {
                            setState(() {
                              item.isExpanded = !item.isExpanded;
                            });
                          },
                        ),
                        isExpanded: item.isExpanded,
                        canTapOnHeader:
                            true, // Allow tapping the header to toggle expansion
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(
      headerValue: 'Artist',
      expandedValue:
          'Jamini Roy,Kalipada,Ghoshal',
    ),
    
  ];
}

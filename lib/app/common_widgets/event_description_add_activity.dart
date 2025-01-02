import 'package:flutter/material.dart';

class EventDescriptionAddActivity extends StatefulWidget {
  const EventDescriptionAddActivity({
    super.key,
    required this.activityController,
    required this.startTimeController,
    required this.endTimeController,
    required this.artistController,
    required this.descriptionController,
  });

  final TextEditingController activityController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController artistController;
  final TextEditingController descriptionController;

  @override
  State<EventDescriptionAddActivity> createState() => _EventDescriptionAddActivityState();
}

class _EventDescriptionAddActivityState extends State<EventDescriptionAddActivity> {



 //this method for time picker
 Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Change the theme if needed
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        //startTimeController.text = picked.format(context);
        widget.startTimeController.text=picked.format(context); // Format time as per the locale
        
      });
    }
  }

  Future<void> _selectTime1(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Change the theme if needed
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        //startTimeController.text = picked.format(context);
        widget.endTimeController.text=picked.format(context); // Format time as per the locale
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF760ABE),
      title: const Text(
        'Add Activity',
        style: TextStyle(color: Colors.black87),
      ),
      content: Scrollbar(
        thickness: 10,
        thumbVisibility: true, // Makes the scrollbar thumb visible
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget.activityController,
                decoration: const InputDecoration(
                  labelText: 'Activity Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:  GestureDetector(
          onTap: () => _selectTime(context),
          child: AbsorbPointer( // Prevents manual input in the TextFormField
            child: TextFormField(
              
              controller: widget.startTimeController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.watch_later,color: Colors.white,),
                labelText: 'Start Time',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),)),
                  
                  const SizedBox(width: 10),
                  Expanded(
                    child:  GestureDetector(
          onTap: () => _selectTime1(context),
          child: AbsorbPointer( // Prevents manual input in the TextFormField
            child: TextFormField(
              controller: widget.endTimeController,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.watch_later,color: Colors.white,),
                labelText: 'End Time',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: widget.artistController,
                decoration: const InputDecoration(
                  labelText: 'Artist Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: widget.descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            // Handle form submission
            print('Activity Name: ${widget.activityController.text}');
            print('Start Time: ${widget.startTimeController.text}');
            print('End Time: ${widget.endTimeController.text}');
            print('Artist Name: ${widget.artistController.text}');
            print('Description: ${widget.descriptionController.text}');
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Submit',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

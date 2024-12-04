import 'package:flutter/material.dart';

class EventDescriptionAddActivity extends StatelessWidget {
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
                controller: activityController,
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
                    child: TextFormField(
                      controller: startTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: endTimeController,
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: artistController,
                decoration: const InputDecoration(
                  labelText: 'Artist Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
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
            print('Activity Name: ${activityController.text}');
            print('Start Time: ${startTimeController.text}');
            print('End Time: ${endTimeController.text}');
            print('Artist Name: ${artistController.text}');
            print('Description: ${descriptionController.text}');
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

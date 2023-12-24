import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Priority { low, medium, high }

class CardWidget extends StatelessWidget {
  final String time;
  final String doctorName;
  final String clinicName;
  final Priority priority;

  const CardWidget({
    Key? key,
    required this.time,
    required this.doctorName,
    required this.clinicName,
    this.priority = Priority.low,
  }) : super(key: key);

  Color _getPriorityColor() {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.yellow;
      case Priority.high:
        return Colors.red;
    }
  }

  bool _isVisitMissed() {
    // Parse the scheduled time
    final scheduledTime = DateTime.parse(time);

    // Compare with the current time
    return DateTime.now().isAfter(scheduledTime);
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Visit'),
              onTap: () {
                Navigator.pop(context);
                // Implement the visit logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                // Implement the edit logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                // Implement the delete logic
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMissed = _isVisitMissed();

    return GestureDetector(
      onTap: () => _showOptions(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: isMissed ? 0.0 : 5.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        color:
            isMissed ? Colors.grey : const Color.fromARGB(255, 237, 232, 185),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Section - Time
              Column(
                children: [
                  Text(
                    DateFormat.jm().format(DateTime.parse(time)),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 2,
                  ),
                  // Additional time-related information
                ],
              ),
              const SizedBox(width: 16.0),
              // Middle Section - Doctor's Name and Clinic's Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      clinicName,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    if (isMissed)
                      const Text(
                        'Missed Visit',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // Right Section - Priority Icon or Image
              CircleAvatar(
                backgroundColor: _getPriorityColor(),
                child: Text(
                  priority.toString().substring(8).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

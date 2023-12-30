import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nurene_app/themes/app_colors.dart';
import '../utils/Priority.dart';
import 'dashed_divider_widget.dart';

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
    final scheduledTime = DateTime.parse(time).toLocal();

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
      onTap: () {}, //=> _showOptions(context),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: isMissed ? 0.0 : 5.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            color: isMissed
                ? Colors.grey
                : const Color.fromARGB(255, 239, 233,
                    233), // const Color.fromARGB(255, 194, 172, 211),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Section - Time
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                            DateFormat.jm()
                                .format(DateTime.parse(time).toLocal()),
                            style: GoogleFonts.rajdhani(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 119, 113, 118),
                                fontSize: 21.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Container(
                        height: 60,
                        width: 5,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFF7882A4),
                        ),
                      ),

                      // Additional time-related information
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                // Middle Section - Doctor's Name and Clinic's Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. $doctorName',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 21.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Text(
                            //'Apollo Hospitals',
                            clinicName,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(137, 43, 43, 43),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (isMissed)
                            const Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.redAccent,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'you missed the visit',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                Container(
                  height: 100,
                  width: 50,
                  //padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: _getPriorityColor(),
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child:
                          Text(priority.toString().substring(8).toUpperCase(),
                              style: GoogleFonts.cairo(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                    ),
                  ),
                ),
                // const Text
                //   'Priority',
                //   style: TextStyle(
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // )
                // Right Section - Priority Icon or Image
                // CircleAvatar(
                //   backgroundColor: _getPriorityColor(),
                //   child: Text(
                //     priority.toString().substring(8).toUpperCase(),
                //     style: const TextStyle(
                //         fontSize: 12, fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          ),
          // Card(
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //   elevation: 5.0,
          //   margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          //   color: Colors
          //       .yellowAccent, // You can replace this with your lavender color
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         // Left Section - Time
          //         RotatedBox(
          //           quarterTurns: 3,
          //           child: Text(
          //             '12:00 pm',
          //             style: const TextStyle(
          //               color: Colors.black,
          //               fontSize: 18.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //         const SizedBox(width: 8.0),
          //         // Divider
          //         VerticalDivider(
          //           color: Colors.grey,
          //           width: 20,
          //           thickness: 2,
          //         ),
          //         const SizedBox(width: 8.0),
          //         // Middle Section - Doctor's Name and Clinic's Name
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Dr. Ruchi Rai',
          //                 style: const TextStyle(
          //                   fontSize: 18.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               const SizedBox(height: 8.0),
          //               Text(
          //                 'Apollo Clinic',
          //                 style: const TextStyle(fontSize: 16.0),
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(width: 8.0),
          //         // Right Section - Priority Badge and Text
          //         Container(
          //           width: 0.1 *
          //               MediaQuery.of(context)
          //                   .size
          //                   .width, // 20% of the screen width
          //           padding: const EdgeInsets.symmetric(vertical: 8.0),
          //           color: Colors
          //               .green, // You can replace this with your green color
          //           child: RotatedBox(
          //             quarterTurns: 1,
          //             child: Text(
          //               'Low Priority',
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          DashedDivider()
        ],
      ),
    );
  }
}

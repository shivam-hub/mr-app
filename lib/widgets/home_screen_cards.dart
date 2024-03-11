import 'package:Nurene/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/master_screen/master_screen.dart';
import '../utils/Priority.dart';
import 'dashed_divider_widget.dart';

class CardWidget extends StatelessWidget {
  final String doctorName;
  final String clinicName;
  final String scheduleVisitId;
  final String doctorId;
  final Priority priority;
  final String scheduleDate;
  final bool isVisited;

  const CardWidget({
    Key? key,
    required this.doctorName,
    required this.clinicName,
    this.priority = Priority.low,
    required this.scheduleVisitId,
    required this.doctorId,
    required this.isVisited,
    required this.scheduleDate,
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

  @override
  Widget build(BuildContext context) {
    final String status = isVisited ? "Visited" : "Not Visited";
    return GestureDetector(
      onTap: () {
        if (isVisited) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Action Invalid",
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                  backgroundColor: const Color.fromARGB(255, 239, 250, 208),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  content: Text("You have already visited the doctor",
                      style: GoogleFonts.montserrat()),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Ok",
                            style: GoogleFonts.montserrat(
                                color: AppColors.appThemeDarkShade1)))
                  ],
                );
              });
          return;
        }

        final currentDate = DateTime.now().toLocal();
        final scheduledDate = DateTime.parse(scheduleDate).toLocal();

        if (currentDate.year == scheduledDate.year &&
            currentDate.month == scheduledDate.month &&
            currentDate.day == scheduledDate.day) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MasterScreen(drId: doctorId, scheduleId: scheduleVisitId),
            ),
          );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Action Invalid",
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                  backgroundColor: const Color.fromARGB(255, 239, 250, 208),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  content: Text(
                      "You can visit the doctor only on the scheduled day",
                      style: GoogleFonts.montserrat()),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Ok",
                            style: GoogleFonts.montserrat(
                                color: AppColors.appThemeDarkShade1)))
                  ],
                );
              });
        }
      },
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: isVisited ? 0.0 : 5.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            color: const Color.fromARGB(255, 239, 250, 208),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Container(
                        height: 80,
                        width: 5,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColors.appThemeDarkShade3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          !doctorName.toLowerCase().startsWith('dr')
                              ? 'Dr. $doctorName'
                              : doctorName,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Text(
                            clinicName,
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(137, 43, 43, 43),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              status,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.lato(
                                  color: isVisited
                                      ? Colors.green[400]
                                      : Colors.red),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                Container(
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    color: _getPriorityColor(),
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child:
                          Text(priority.toString().substring(8).toUpperCase(),
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const DashedDivider()
        ],
      ),
    );
  }
}

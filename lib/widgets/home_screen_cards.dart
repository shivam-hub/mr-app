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
  final bool isVisited;

  const CardWidget({
    Key? key,
    required this.doctorName,
    required this.clinicName,
    this.priority = Priority.low,
    required this.scheduleVisitId,
    required this.doctorId,
    required this.isVisited,
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

  // bool _isVisitMissed() {
  //   final scheduledTime = DateTime.parse(time).toLocal();
  //   return DateTime.now().isAfter(scheduledTime);
  // }

  @override
  Widget build(BuildContext context) {
    // final bool isMissed = _isVisitMissed();
    final String status = isVisited ? "Visited" : "Not Visited";
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MasterScreen(drId: doctorId, scheduleId: scheduleVisitId),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: isVisited ? 0.0 : 5.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            color: isVisited ? Colors.grey : Colors.white,
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
                          // if (isMissed)
                          //   const Row(
                          //     children: [
                          //       SizedBox(
                          //         width: 8,
                          //       ),
                          //       Icon(
                          //         Icons.error_outline,
                          //         color: Colors.redAccent,
                          //         size: 16,
                          //       ),
                          //       SizedBox(
                          //         width: 2,
                          //       ),
                          //       Text(
                          //         'you missed the visit',
                          //         style: TextStyle(
                          //             color: Colors.redAccent,
                          //             fontStyle: FontStyle.italic),
                          //       ),
                          //     ],
                          //   ),
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

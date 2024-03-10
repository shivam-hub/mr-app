import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/themes/app_colors.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay selectedTime) onTimeSelected;

  const TimePickerWidget({super.key, required this.onTimeSelected});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:
                  AppColors.textFieldBorderColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Color.fromARGB(255, 150, 121, 133), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });

      widget.onTimeSelected(_selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        height: 50,
        width: 125,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border:
              Border(bottom: BorderSide(color: AppColors.textFieldBorderColor)),
        ),
        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedTime.format(context),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            const Icon(Icons.access_time_rounded,
                color: AppColors.textFieldBorderColor),
          ],
        ),
      ),
    );
  }
}

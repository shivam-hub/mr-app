import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';

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
                  Color.fromARGB(255, 179, 172, 87), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.brown, // body text color
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
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 50,
          width: 125,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 235, 216),
            border: Border.all(color: AppColors.textFieldBorderColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedTime.format(context),
                style: const TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 16.0,
                  //color: Color.fromARGB(255, 34, 32, 31),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Icon(Icons.access_time_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

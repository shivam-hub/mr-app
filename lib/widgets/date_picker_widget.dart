import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/themes/app_colors.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected;

  const DatePickerWidget({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate:
          DateTime.now(), // Updated to disable dates before the current date
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.textFieldBorderColor,
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 150, 121, 133),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: 50,
        width: 150,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border:
              Border(bottom: BorderSide(color: AppColors.textFieldBorderColor)),
        ),
        padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_selectedDate.toLocal()}'.split(' ')[0],
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.calendar_today,
                color: AppColors.textFieldBorderColor),
          ],
        ),
      ),
    );
  }
}

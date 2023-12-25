import 'package:flutter/material.dart';
import 'package:nurene_app/themes/app_colors.dart';
import 'package:nurene_app/widgets/text_field_widget.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected;

  const DatePickerWidget({super.key, required this.onDateSelected});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:
                  Color.fromARGB(255, 236, 232, 185), // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.brown, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
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
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textFieldBorderColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_selectedDate.toLocal()}'.split(' ')[0],
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}

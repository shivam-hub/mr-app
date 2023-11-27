import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/themes/app_colors.dart';
import 'package:nurene_app/widgets/appbar_widget.dart';
import 'package:nurene_app/widgets/bottom_navigationbar_widget.dart';
import '../blocs/plan_visit/plan_visit_bloc.dart';
import '../models/dropdown_value_model.dart';
import '../widgets/dropdown_text_field.dart';
import '../widgets/text_field_widget.dart';
import '../blocs/plan_visit/plan_visit_event.dart';
import '../blocs/plan_visit/plan_visit_state.dart';

class PlanVisitScreen extends StatefulWidget {
  const PlanVisitScreen({super.key});

  @override
  State<PlanVisitScreen> createState() => _PlanVisitScreenState();
}

class _PlanVisitScreenState extends State<PlanVisitScreen> {
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _pincodeController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: const AppBarWidget(
          appBarTitle: "Plan Visit",
          prefixIcon:
              Icon(Icons.arrow_back_outlined, color: Colors.brown, size: 25),
          gradient: AppColors.appBarColorGradient,
        ),
        body: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: DropdownTextFieldWidget(
                prefixText: "Dr. ",
                placeholder: 'Doctor\'s Name',
                dropDownOption: const [
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value"),
                  DropDownOption(name: "name", value: "value")
                ],
                onChanged: (value) {
                  BlocProvider.of<PlanVisitBloc>(context)
                      .add(DoctorSelectedEvent(value));
                },
              ),
            ),
            const SizedBox(height: 30),
            TextFieldWidget(
              label: 'Address',
              controller: _addressController,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: TextFieldWidget(
                  label: 'City',
                  controller: _cityController,
                )),
                Expanded(
                    child: TextFieldWidget(
                  label: 'Pincode',
                  controller: _pincodeController,
                ))
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: TextFieldWidget(
                  label: 'State',
                  controller: _stateController,
                )),
                Expanded(
                    child: TextFieldWidget(
                  label: 'Region',
                  controller: _regionController,
                ))
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Theme(
                data: ThemeData(
                    colorScheme: const ColorScheme.light()
                        .copyWith(background: AppColors.backgroundColor),
                        primaryColor: AppColors.backgroundColor
                        ),
                child: DateTimePicker(
                  use24HourFormat: false,
                  dateLabelText: "Select Date label",
                  dateHintText: "date hint text",
                  timeLabelText: "Select Time",
                  decoration: InputDecoration(
                    floatingLabelStyle: const TextStyle(color: Colors.brown),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: AppColors.textFieldBorderColor),
                    ),
                  ),
                  type: DateTimePickerType.dateTimeSeparate,
                  icon: const Icon(Icons.event),
                  fieldLabelText: 'Select Date and Time',
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}

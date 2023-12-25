import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/services/api_services.dart';
import 'package:nurene_app/services/locator.dart';
import '../blocs/plan_visit/plan_visit_bloc.dart';
import '../themes/app_colors.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/autocomplete_widget.dart';
import '../widgets/bottom_navigationbar_widget.dart';
import '../models/dropdown_value_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/dropdown_text_field.dart';
import '../widgets/text_field_widget.dart';
import '../blocs/plan_visit/plan_visit_event.dart';
import '../blocs/plan_visit/plan_visit_state.dart';
import '../widgets/time_picker_widget.dart';

class PlanVisitScreen extends StatefulWidget {
  const PlanVisitScreen({super.key});

  @override
  State<PlanVisitScreen> createState() => _PlanVisitScreenState();
}

class _PlanVisitScreenState extends State<PlanVisitScreen> {
  TimeOfDay? _selectedTime;

  DateTime? _seledtedDate;

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _pincodeController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();

  final TextEditingController _doctorNameController = TextEditingController();

  final SingleValueDropDownController _doctorTypeController =
      SingleValueDropDownController();

  final SingleValueDropDownController _stateController =
      SingleValueDropDownController();

  late final Map<String, dynamic> doctorDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          appBarTitle: "Plan Visit",
          prefixIcon: IconButton(
              icon: const Icon(Icons.arrow_back_outlined,
                  color: Colors.brown, size: 25),
              onPressed: () => Navigator.of(context).pop()),
          gradient: AppColors.appBarColorGradient,
        ),
        body: BlocProvider(
          create: (context) => PlanVisitBloc(locator<ApiService>()),
          child: BlocBuilder<PlanVisitBloc, PlanVisitState>(
              builder: (context, state) {
            if (state is PlanVisitLoadingState) {
              return const CircularProgressIndicator();
            } else {
              if (state is DoctorSelectedState) {
                _doctorTypeController.dropDownValue = DropDownValueModel(
                    name: state.doctorDetails['speciality'],
                    value: state.doctorDetails['speciality']);

                final addressLine1 =
                    state.doctorDetails['addressInfo']?['addressline1'] ?? '';
                final addressLine2 =
                    state.doctorDetails['addressInfo']?['addressline2'] ?? '';
                _addressController.text = "$addressLine1 , $addressLine2";

                _cityController.text =
                    state.doctorDetails['addressInfo']['city'].toString();

                _pincodeController.text =
                    state.doctorDetails['addressInfo']['pincode'].toString();

                _stateController.dropDownValue = DropDownValueModel(
                    name: state.doctorDetails['addressInfo']['state'],
                    value: state.doctorDetails['addressInfo']['state']);

                _regionController.text =
                    state.doctorDetails['addressInfo']['region'].toString();
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: AutoCompleteWidget(
                          prefixText: 'Dr. ',
                          placeholder: 'Doctor\'s Name',
                          textEditingController: _doctorNameController,
                          onSelected: (Map<String, dynamic> optionNode) {
                            doctorDetails = optionNode;
                            BlocProvider.of<PlanVisitBloc>(context)
                                .add(DoctorSelectedEvent(optionNode));
                          },
                          readOnly: state is DoctorSelectedState,
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: DropdownTextFieldWidget(
                        placeholder: 'Doctor Type',
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
                        readonly: state is DoctorSelectedState,
                        controller: _doctorTypeController,
                        onChanged: (value) {
                          // BlocProvider.of<MasterBloc>(context)
                          //     .add(DoctorSelectedEvent(value));
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFieldWidget(
                        label: 'Address',
                        controller: _addressController,
                        readOnly: state is DoctorSelectedState,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: TextFieldWidget(
                            label: 'City',
                            controller: _cityController,
                            readOnly: state is DoctorSelectedState,
                          )),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: TextFieldWidget(
                            label: 'Pincode',
                            controller: _pincodeController,
                            readOnly: state is DoctorSelectedState,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            //     child: TextFieldWidget(
                            //   label: 'State',
                            //   controller: _stateController,
                            // )
                            child: DropdownTextFieldWidget(
                              placeholder: 'State',
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
                              controller: _stateController,
                              readonly: state is DoctorSelectedState,
                              onChanged: (value) {
                                // BlocProvider.of<PlanVisitBloc>(context)
                                //     .add(DoctorSelectedEvent(value));
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: TextFieldWidget(
                            label: 'Region',
                            controller: _regionController,
                            readOnly: state is DoctorSelectedState,
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DatePickerWidget(
                            onDateSelected: (DateTime selectedDate) {
                              setState(() {
                                _seledtedDate = selectedDate;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          TimePickerWidget(
                              onTimeSelected: (TimeOfDay selectedTime) {
                            setState(() {
                              _selectedTime = selectedTime;
                            });
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ButtonWidget(
                          onPressed: () {
                            BlocProvider.of<PlanVisitBloc>(context).add(
                              SavePlanVisitDataEvent(
                                  doctorDetails: doctorDetails,
                                  time: _selectedTime!.format(context),
                                  date: _seledtedDate.toString()),
                            );
                          },
                          width: 100,
                          height: 40,
                          labelFontSize: 18,
                          label: 'Save',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          gradientB: AppColors.bottomNavBarColorGradient,
        ),
      ),
    );
  }
}

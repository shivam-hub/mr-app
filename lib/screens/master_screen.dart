import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/widgets/button_widget.dart';
import 'package:nurene_app/widgets/image_picker_widget.dart';
import '../blocs/master/master_bloc.dart';
import '../blocs/master/master_event.dart';
import '../blocs/master/master_state.dart';
import '../models/dropdown_value_model.dart';
import '../themes/app_colors.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/autocomplete_widget.dart';
import '../widgets/bottom_navigationbar_widget.dart';
import '../widgets/dropdown_text_field.dart';
import '../widgets/text_field_widget.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final TextEditingController _addressLine1Controller = TextEditingController();

  final TextEditingController _addressLine2Controller = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _pincodeController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();

  final TextEditingController _doctorIdController = TextEditingController();

  final SingleValueDropDownController _doctorTypeController =
      SingleValueDropDownController();

  final SingleValueDropDownController _stateController =
      SingleValueDropDownController();

  String selectedDoctorName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        appBarTitle: "Master",
        prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back_outlined,
                color: Colors.brown, size: 25),
            onPressed: () => Navigator.of(context).pop()),
        gradient: AppColors.appBarColorGradient,
      ),
      body: BlocProvider(
        create: (context) => MasterBloc(),
        child: BlocBuilder<MasterBloc, MasterState>(
          builder: (context, state) {
            if (state is MasterLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is MasterErrorState) {
              return Text('Error: ${state.errorMessage}');
            } else if (state is MasterSuccessState) {
              return const Text('Data saved successfully!');
            } else {
              if (state is DoctorSelectedState) {
                _doctorIdController.text =
                    state.doctorDetails['drId'].toString();
                _addressLine1Controller.text = state
                    .doctorDetails['addressInfo']['addressline1']
                    .toString();
                _addressLine2Controller.text = state
                    .doctorDetails['addressInfo']['addressline2']
                    .toString();
                _cityController.text =
                    state.doctorDetails['addressInfo']['city'].toString();
                _pincodeController.text =
                    state.doctorDetails['addressInfo']['pincode'].toString();
                _regionController.text =
                    state.doctorDetails['addressInfo']['region'].toString();
                _stateController.dropDownValue = DropDownValueModel(
                    name: state.doctorDetails['addressInfo']['state'],
                    value: state.doctorDetails['addressInfo']['state']);
                _doctorTypeController.dropDownValue = DropDownValueModel(
                    name: state.doctorDetails['speciality'],
                    value: state.doctorDetails['speciality']);
              }
              return ListView(
                children: [
                  const ListTile(
                    titleAlignment: ListTileTitleAlignment.top,
                    textColor: Color.fromARGB(255, 65, 81, 90),
                    titleTextStyle:
                        TextStyle(fontWeight: FontWeight.w600, shadows: [
                      Shadow(
                        color:
                            Color.fromARGB(255, 201, 195, 195), // shadow color
                        offset: Offset(5.0, 3.0), // shadow offset
                        blurRadius: 10, // shadow blur radius
                      ),
                    ]),
                    title:
                        Text('Basic Details', style: TextStyle(fontSize: 30)),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFieldWidget(
                      label: "Doctor Id",
                      controller: _doctorIdController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Static Doctor Id for example
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: AutoCompleteWidget<Map<String, dynamic>>(
                        prefixText: 'Dr. ',
                        placeholder: 'Doctor\'s Name',
                        onSelected: (Map<String, dynamic> optionNode) {
                          BlocProvider.of<MasterBloc>(context)
                              .add(DoctorSelectedEvent(optionNode));
                        },
                      readOnly: state is DoctorSelectedState,
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: DropdownTextFieldWidget(
                      placeholder: 'Doctor Type',
                      controller: _doctorTypeController,
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
                    ),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.all(20),
                    textColor: Color.fromARGB(255, 65, 81, 90),
                    titleTextStyle:
                        TextStyle(fontWeight: FontWeight.w600, shadows: [
                      Shadow(
                        color:
                            Color.fromARGB(255, 201, 195, 195), // shadow color
                        offset: Offset(5.0, 3.0), // shadow offset
                        blurRadius: 10, // shadow blur radius
                      ),
                    ]),
                    title: Text('Address', style: TextStyle(fontSize: 30)),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFieldWidget(
                      label: 'Address Line 1',
                      controller: _addressLine1Controller,
                      readOnly: state is DoctorSelectedState,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFieldWidget(
                      label: 'Address Line 2',
                      controller: _addressLine2Controller,
                      readOnly: state is DoctorSelectedState,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            label: 'City',
                            controller: _cityController,
                            readOnly: state is DoctorSelectedState,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFieldWidget(
                            label: 'Pincode',
                            controller: _pincodeController,
                            readOnly: state is DoctorSelectedState,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownTextFieldWidget(
                            placeholder: 'State',
                            controller: _stateController,
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
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFieldWidget(
                            label: 'Region',
                            controller: _regionController,
                            readOnly: state is DoctorSelectedState,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.all(20),
                    textColor: Color.fromARGB(255, 65, 81, 90),
                    titleTextStyle:
                        TextStyle(fontWeight: FontWeight.w600, shadows: [
                      Shadow(
                        color:
                            Color.fromARGB(255, 201, 195, 195), // shadow color
                        offset: Offset(5.0, 3.0), // shadow offset
                        blurRadius: 10, // shadow blur radius
                      ),
                    ]),
                    title: Text('Uploads', style: TextStyle(fontSize: 30)),
                  ),

                  // Add your photo upload widget here
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Material(
                      elevation: 15,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppColors.textFieldBorderColor),
                          ),
                          height: 100,
                          width: 60,

                          // width: MediaQuery.of(context).size.width * 0.8,
                          child: const Center(child: PickImage())),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ButtonWidget(
                        onPressed: () {
                          BlocProvider.of<MasterBloc>(context).add(
                            SaveMasterDataEvent(
                              doctorId: '12345', // Static Doctor Id for example
                              doctorName: "",
                              addressLine1: _addressLine1Controller.text,
                              addressLine2: _addressLine2Controller.text,
                              city: _cityController.text,
                              pincode: _pincodeController.text,
                              state: _stateController.dropDownValue.toString(),
                              region: _regionController.text,
                              photoPath: '', // Set the photo path here
                            ),
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
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        gradientB: AppColors.bottomNavBarColorGradient,
      ),
    );
  }
}

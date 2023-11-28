import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/widgets/button_widget.dart';
import '../blocs/master/master_bloc.dart';
import '../blocs/master/master_event.dart';
import '../blocs/master/master_state.dart';
import '../models/dropdown_value_model.dart';
import '../themes/app_colors.dart';
import '../widgets/appbar_widget.dart';
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

  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();

  final TextEditingController _doctorIdController = TextEditingController();

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
              return ListView(
                children: [
                  const ListTile(
                    title:
                        Text('Basic Details', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 120),
                  TextFieldWidget(
                    label: "Doctor Id",
                    controller: _doctorIdController,
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  // Static Doctor Id for example
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: DropdownTextFieldWidget(
                      prefixText: "Dr. ",
                      placeholder: 'Doctor\'s Name',
                      dropDownOption: const [
                        DropDownOption(
                            name: 'Dr. John Doe', value: 'Dr. John Doe'),
                        DropDownOption(
                            name: 'Dr. Jane Smith', value: 'Dr. Jane Smith'),
                        // Add more doctor options
                      ],
                      onChanged: (value) {
                        BlocProvider.of<MasterBloc>(context)
                            .add(DoctorSelectedEvent(value));
                      },
                    ),
                  ),
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
                      onChanged: (value) {
                        // BlocProvider.of<MasterBloc>(context)
                        //     .add(DoctorSelectedEvent(value));
                      },
                    ),
                  ),
                  const ListTile(
                    title:
                        Text('Address Details', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Address Line 1',
                    controller: _addressLine1Controller,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Address Line 2',
                    controller: _addressLine2Controller,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'City',
                          controller: _cityController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Pincode',
                          controller: _pincodeController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                            onChanged: (value) {
                              BlocProvider.of<MasterBloc>(context)
                                  .add(DoctorSelectedEvent(value));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Region',
                          controller: _regionController,
                        ),
                      ),
                    ],
                  ),
                  // Add your photo upload widget here
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
                              doctorName: state is DoctorSelectedState
                                  ? state.doctorName
                                  : '',
                              addressLine1: _addressLine1Controller.text,
                              addressLine2: _addressLine2Controller.text,
                              city: _cityController.text,
                              pincode: _pincodeController.text,
                              state: _stateController.text,
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
      bottomNavigationBar: const BottomNavigationBarWidget(
        gradientB: AppColors.bottomNavBarColorGradient,
      ),
    );
  }
}

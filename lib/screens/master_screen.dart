import 'dart:io';
import 'package:nurene_app/widgets/image_picker_widget.dart';
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

  String selectedImagePath = '';

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
                    child: DropdownTextFieldWidget(
                      prefixText: "Dr. ",
                      placeholder: 'Doctor\'s Name',
                      dropDownOption: const [
                        DropDownOption(name: 'John Doe', value: 'Dr. John Doe'),
                        DropDownOption(
                            name: 'Jane Smith', value: 'Dr. Jane Smith'),
                        // Add more doctor options
                      ],
                      onChanged: (value) {
                        // BlocProvider.of<MasterBloc>(context)
                        //     .add(DoctorSelectedEvent(value));
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
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFieldWidget(
                      label: 'Address Line 2',
                      controller: _addressLine2Controller,
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
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFieldWidget(
                            label: 'Pincode',
                            controller: _pincodeController,
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
                          child: Container(
                            //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                // BlocProvider.of<MasterBloc>(context)
                                //     .add(DoctorSelectedEvent(value));
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFieldWidget(
                            label: 'Region',
                            controller: _regionController,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedImagePath == ''
                          ? Image.asset(
                              'asset/images/image.jpg',
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(selectedImagePath),
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 14, color: Colors.white))),
                          onPressed: () async {
                            selectImage(context);
                            setState(() {});
                          },
                          child: const Text('Upload')),
                      const SizedBox(height: 10),
                    ],
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
      bottomNavigationBar: BottomNavigationBarWidget(
        gradientB: AppColors.bottomNavBarColorGradient,
      ),
    );
  }
}

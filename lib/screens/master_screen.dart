import 'dart:html';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:nurene_app/services/api_services.dart';
import 'package:nurene_app/utils/const.dart';
import 'package:nurene_app/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/widgets/button_widget.dart';
import '../blocs/master/master_bloc.dart';
import '../blocs/master/master_event.dart';
import '../blocs/master/master_state.dart';
import '../models/dropdown_value_model.dart';
import '../services/locator.dart';
import '../themes/app_colors.dart';
import '../utils/GeolocatorUtil.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/autocomplete_widget.dart';
import '../widgets/bottom_navigationbar_widget.dart';
import '../widgets/dropdown_text_field.dart';
import '../widgets/medical_details_widget.dart';
import '../widgets/text_field_widget.dart';
import 'package:quickalert/quickalert.dart';

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

  String selectedImagePath = '';
  late final Map<String, dynamic> doctorDetails;

  void showAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Submitted!',
        text: 'Your details has been updated successfully',
        confirmBtnColor: const Color.fromARGB(255, 189, 187, 187));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          create: (context) => MasterBloc(locator<ApiService>()),
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
                } else if (state is MasterFormResetState) {
                  _doctorIdController.clear();
                  _doctorTypeController.clearDropDown();
                  _addressLine1Controller.clear();
                  _addressLine2Controller.clear();
                  _cityController.clear();
                  _pincodeController.clear();
                  _stateController.clearDropDown();
                  _regionController.clear();
                }
                return ListView(
                  children: [
                    const ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      textColor: Color.fromARGB(255, 65, 81, 90),
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.w600, shadows: [
                        Shadow(
                          color: Color.fromARGB(
                              255, 201, 195, 195), // shadow color
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
                        label: "Doctor Registration No.",
                        controller: _doctorIdController,
                        readOnly: state is DoctorSelectedState,
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
                            doctorDetails = optionNode;
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
                          color: Color.fromARGB(
                              255, 201, 195, 195), // shadow color
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
                              dropDownOption: Constants.states,
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
                          color: Color.fromARGB(
                              255, 201, 195, 195), // shadow color
                          offset: Offset(5.0, 3.0), // shadow offset
                          blurRadius: 10, // shadow blur radius
                        ),
                      ]),
                      title: Text('Associated Medical',
                          style: TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: MedicalStoreDetailsWidget(),
                    ),

                    const ListTile(
                      contentPadding: EdgeInsets.all(20),
                      textColor: Color.fromARGB(255, 65, 81, 90),
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.w600, shadows: [
                        Shadow(
                          color: Color.fromARGB(
                              255, 201, 195, 195), // shadow color
                          offset: Offset(5.0, 3.0), // shadow offset
                          blurRadius: 10, // shadow blur radius
                        ),
                      ]),
                      title: Text('Feedback', style: TextStyle(fontSize: 30)),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 237, 235, 216),
                            labelText: 'Enter your feedback',
                            floatingLabelStyle:
                                const TextStyle(color: Colors.brown),
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
                        ),
                      ),
                    ),

                    const ListTile(
                      contentPadding: EdgeInsets.all(20),
                      textColor: Color.fromARGB(255, 65, 81, 90),
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.w600, shadows: [
                        Shadow(
                          color: Color.fromARGB(
                              255, 201, 195, 195), // shadow color
                          offset: Offset(5.0, 3.0), // shadow offset
                          blurRadius: 10, // shadow blur radius
                        ),
                      ]),
                      title: Text('Uploads', style: TextStyle(fontSize: 30)),
                    ),

                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.textFieldBorderColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 237, 235, 216),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.textFieldBorderColor,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                              const VerticalDivider(
                                color: AppColors.textFieldBorderColor,
                                thickness: 2,
                                indent: 10,
                                endIndent: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  selectImage(context);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 237, 235, 216),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add Image',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Tap to select from gallery',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonWidget(
                              onPressed: () {
                                BlocProvider.of<MasterBloc>(context)
                                    .add(MasterFormReset());
                              },
                              width: 100,
                              height: 40,
                              labelFontSize: 18,
                              label: 'Reset',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonWidget(
                              onPressed: () {
                                GeolocatorUtil.checkLocationServices(context);
                                BlocProvider.of<MasterBloc>(context).add(
                                  SaveMasterDataEvent(
                                    filePath: '',
                                    doctorDetails: doctorDetails,
                                  ),
                                );
                                showAlert();
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
                  ],
                );
              }
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          gradientB: AppColors.bottomNavBarColorGradient,
          initialIndex: 2,
        ),
      ),
    );
  }
}

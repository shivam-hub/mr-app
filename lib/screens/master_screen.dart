import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:nurene_app/models/MedicalStoreModel.dart';
import 'package:nurene_app/models/plan_visit_model.dart';
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

GlobalKey<MedicalStoreDetailsWidgetState> medicalStoreDetailsWidgetKey =
    GlobalKey<MedicalStoreDetailsWidgetState>();
final _formKey = GlobalKey<FormState>();

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

  final TextEditingController _doctRegNumber = TextEditingController();

  final SingleValueDropDownController _doctorTypeController =
      SingleValueDropDownController();

  final SingleValueDropDownController _stateController =
      SingleValueDropDownController();

  String selectedImagePath = '';
  DoctorInfo doctorDetails = DoctorInfo();

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
                  final docInfo = DoctorInfo.fromJson(state.doctorDetails);
                  _doctRegNumber.text = docInfo.drId ?? '';
                  _addressLine1Controller.text =
                      docInfo.addressInfo?.addressline1 ?? '';
                  _addressLine2Controller.text =
                      docInfo.addressInfo?.addressline2 ?? '';
                  _cityController.text = docInfo.addressInfo?.city ?? '';
                  _pincodeController.text = docInfo.addressInfo?.pincode ?? '';
                  _regionController.text = docInfo.addressInfo?.region ?? '';
                  _stateController.dropDownValue = DropDownValueModel(
                      name: docInfo.addressInfo?.state ?? '',
                      value: docInfo.addressInfo?.state ?? '');
                  _doctorTypeController.dropDownValue = DropDownValueModel(
                      name: docInfo.speciality ?? '',
                      value: docInfo.speciality ?? '');
                } else if (state is MasterFormResetState) {
                  _doctRegNumber.clear();
                  _doctorTypeController.clearDropDown();
                  _addressLine1Controller.clear();
                  _addressLine2Controller.clear();
                  _cityController.clear();
                  _pincodeController.clear();
                  _stateController.clearDropDown();
                  _regionController.clear();
                }
                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        textColor: Color.fromARGB(255, 65, 81, 90),
                        titleTextStyle:
                            TextStyle(fontWeight: FontWeight.w600, shadows: [
                          Shadow(
                            color: Color.fromARGB(
                                255, 201, 195, 195), // shadow clor
                            offset: Offset(5.0, 3.0), // shadow offset
                            blurRadius: 10, // shadow blur radius
                          ),
                        ]),
                        title: Text('Basic Details',
                            style: TextStyle(fontSize: 30)),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFieldWidget(
                          formKey: _formKey,
                          label: "Doctor Registration No.",
                          controller: _doctRegNumber,
                          readOnly: state is DoctorSelectedState,
                          validator: (value) {
                            debugPrint(
                                "Inside validator of reg no with value as $value");
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return "Incorrect registeration number";
                            }
                            return null;
                          },
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
                              doctorDetails = DoctorInfo.fromJson(optionNode);
                              BlocProvider.of<MasterBloc>(context)
                                  .add(DoctorSelectedEvent(optionNode));
                            },
                            onEditingComplete: (String value) {
                              debugPrint('Inside master screen $value');
                              doctorDetails.name = value;
                              BlocProvider.of<MasterBloc>(context)
                                  .add(NewDoctorRecordEvent(value));
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
                          formKey: _formKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select doctor type";
                            }
                            return null;
                          },
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
                                formKey: _formKey,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter City";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextFieldWidget(
                                label: 'Pincode',
                                controller: _pincodeController,
                                readOnly: state is DoctorSelectedState,
                                inputType: TextInputType.number,
                                formKey: _formKey,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains(RegExp(r'^[0-9]+$')) ||
                                      value.length != 6) {
                                    return "Please enter valid Pincode";
                                  }
                                  return null;
                                },
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
                        child: MedicalStoreDetailsWidget(
                            medicalStoreDetailsWidgetKey),
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
                              fillColor:
                                  const Color.fromARGB(255, 237, 235, 216),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  if (_formKey.currentState!.validate()) {
                                    GeolocatorUtil.checkLocationServices(
                                        context);
                                    if (state is NewDoctorRecordState) {
                                      final AddressInfo addressInfo =
                                          AddressInfo();
                                      addressInfo.addressline1 =
                                          _addressLine1Controller.text
                                              .toString();
                                      addressInfo.addressline2 =
                                          _addressLine1Controller.text
                                              .toString();
                                      addressInfo.city =
                                          _cityController.text.toString();
                                      addressInfo.pincode =
                                          _pincodeController.text.toString();
                                      addressInfo.region =
                                          _regionController.text.toString();
                                      addressInfo.state = _stateController
                                          .dropDownValue?.name
                                          .toString();

                                      doctorDetails.addressInfo = addressInfo;
                                      List<MedicalStoreModel>
                                          medicalStoreDetails =
                                          medicalStoreDetailsWidgetKey
                                              .currentState!
                                              .getMedicalStoreDetails();
                                      doctorDetails.speciality =
                                          _doctorTypeController
                                              .dropDownValue?.name
                                              .toString();
                                      doctorDetails.associatedMedicals =
                                          medicalStoreDetails;
                                    }
                                    // BlocProvider.of<MasterBloc>(context).add(
                                    //   SaveMasterDataEvent(
                                    //     filePath: '',
                                    //     doctorDetails: doctorDetails.toJson(),
                                    //   ),
                                    // );
                                    showAlert();
                                  }
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
                  ),
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

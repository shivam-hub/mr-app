import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nurene_app/themes/app_styles.dart';
import 'package:nurene_app/widgets/product_selection_widget.dart';
import 'package:quickalert/quickalert.dart';
import '../models/MedicalStoreModel.dart';
import '../services/api_services.dart';
import '../utils/const.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/button_widget.dart';
import '../blocs/master/master_bloc.dart';
import '../blocs/master/master_event.dart';
import '../blocs/master/master_state.dart';
import '../models/address_info_model.dart';
import '../models/doctor_model.dart';
import '../models/dropdown_value_model.dart';
import '../services/locator.dart';
import '../themes/app_colors.dart';
import '../utils/GeolocatorUtil.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/autocomplete_widget.dart';
import '../widgets/dropdown_text_field.dart';
import '../widgets/medical_details_widget.dart';
import '../widgets/text_field_widget.dart';

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
  final TextEditingController _doctRegNumberController =
      TextEditingController();
  final TextEditingController _feedBackController = TextEditingController();
  final SingleValueDropDownController _doctorTypeController =
      SingleValueDropDownController();

  final SingleValueDropDownController _stateController =
      SingleValueDropDownController();

  String selectedImagePath = '';
  DoctorInfo doctorDetails = DoctorInfo();
  File? selectedImage;

  void showAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        animType: QuickAlertAnimType.rotate,
        title: 'Submitted!',
        text: 'Your details has been updated successfully',
        confirmBtnColor: const Color.fromARGB(255, 189, 187, 187));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/home')),
          gradient: AppColors.appBarColorGradient,
        ),
        endDrawer: MyDrawer(userName: 'Ruchi Rai'),
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
                  _doctRegNumberController.text = docInfo.drId ?? '';
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
                  _doctRegNumberController.clear();
                  _doctorTypeController.clearDropDown();
                  _addressLine1Controller.clear();
                  _addressLine2Controller.clear();
                  _cityController.clear();
                  _pincodeController.clear();
                  _stateController.clearDropDown();
                  _regionController.clear();
                  _feedBackController.clear();
                }
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.12,
                        ),
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.top,
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Basic Details',
                              style: TextStyle(fontSize: 30)),
                        ),
                        const SizedBox(height: 5),
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
                              validator: (value) {
                                debugPrint(
                                    "Inside validator of doctor name with value as $value");
                                if (value == null || value.isEmpty) {
                                  return "Please select a doctor's name or enter name";
                                }
                                return null;
                              },
                              onEditingComplete: (String value) {
                                debugPrint('Inside master screen $value');
                                doctorDetails.name = value;
                                if (_formKey.currentState != null) {
                                  _formKey.currentState!.validate();
                                }
                                BlocProvider.of<MasterBloc>(context)
                                    .add(NewDoctorRecordEvent(value));
                              },
                              readOnly: state is DoctorSelectedState,
                            )),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFieldWidget(
                            // formKey: _formKey,
                            label: "Doctor Registration No.",
                            controller: _doctRegNumberController,
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
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Address',
                              style: TextStyle(fontSize: 30)),
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
                                  // formKey: _formKey,
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
                                  // formKey: _formKey,
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
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Associated Medical',
                              style: TextStyle(fontSize: 30)),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: MedicalStoreDetailsWidget(
                            GlobalKey<MedicalStoreDetailsWidgetState>(),
                            _formKey,
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Products',
                              style: TextStyle(fontSize: 30)),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: ProductSelectionWidget()),
                        const SizedBox(height: 2),
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Feedback',
                              style: TextStyle(fontSize: 30)),
                        ),
                        const SizedBox(width: 15),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFieldWidget(
                            minLines: 1,
                            maxLines: 5,
                            label: 'Feedback',
                            controller: _feedBackController,
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Uploads',
                              style: TextStyle(fontSize: 30)),
                        ),

                        // Display selected images as attachments
                        PickImage(
                          onImageSelected: (file) {
                            // Handle the selected image file
                            // For example, you can use it to display the image below your container
                            setState(() {
                              selectedImage = file;
                            });
                          },
                        ),

                        // Display the selected image

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
                                    gradient: AppColors.buttonGradient),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ButtonWidget(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        GeolocatorUtil geolocatorUtil =
                                            GeolocatorUtil();
                                        geolocatorUtil.checkLocationServices();
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
                                              _pincodeController.text
                                                  .toString();
                                          addressInfo.region =
                                              _regionController.text.toString();
                                          addressInfo.state = _stateController
                                              .dropDownValue?.name
                                              .toString();

                                          doctorDetails.addressInfo =
                                              addressInfo;
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
                                        BlocProvider.of<MasterBloc>(context)
                                            .add(
                                          SaveMasterDataEvent(
                                            filePath: '',
                                            doctorDetails:
                                                doctorDetails.toJson(),
                                          ),
                                        );
                                        showAlert();
                                      }
                                    },
                                    width: 100,
                                    height: 40,
                                    labelFontSize: 18,
                                    label: 'Save',
                                    gradient: AppColors.buttonGradient),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.2,
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

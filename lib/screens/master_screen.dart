// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:math';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nurene_app/models/prodcut_model.dart';
import 'package:nurene_app/models/visit_model.dart';
import 'package:nurene_app/screens/home_screen/home_screen.dart';
import 'package:nurene_app/themes/app_styles.dart';
import 'package:nurene_app/utils/AltertUtil.dart';
import 'package:nurene_app/utils/ModelBuilder.dart';
import 'package:nurene_app/widgets/product_selection_widget.dart';
import '../models/medical_store_model.dart';
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
import '../widgets/text_dialog_widget.dart';
import '../widgets/text_field_widget.dart';

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  final ScrollController _scrollController = ScrollController();
  final FocusNode doctorRegNumberFocusNode = FocusNode();
  String doctorName = '';
  GeolocatorUtil geolocatorUtil = GeolocatorUtil();
  AltertUtil altertUtil = AltertUtil();
  List<MedicalStoreModel> medicalStoreDetails = [];
  List<MedicalStoreModel> initialStores = [];
  DoctorInfo doctorDetails = DoctorInfo();
  VisitModel visitModel = VisitModel();
  late List<ProductModel> products;
  File? selectedImage;
  String filePath = '';
  late Position currentPosition;

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
        endDrawer: MyDrawer(),
        body: BlocProvider(
          create: (context) => MasterBloc(locator<ApiService>()),
          child: BlocBuilder<MasterBloc, MasterState>(
            builder: (context, state) {
              if (state is MasterLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is MasterErrorState) {
                return Text('Error: ${state.errorMessage}');
              } else if (state is MasterSuccessState) {
                if (state.isSuccess) {
                  return AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Done'),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(user: state.userModel))),
                          child: const Text('Ok'))
                    ],
                  );
                } else {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Not done'),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(user: state.userModel))),
                          child: const Text('Ok'))
                    ],
                  );
                }
              } else {
                if (state is DoctorSelectedState) {
                  final docInfo = DoctorInfo.fromJson(state.doctorDetails);
                  initialStores = docInfo.associatedMedicals!;
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
                  if (docInfo.speciality!.isNotEmpty) {
                    _doctorTypeController.dropDownValue = DropDownValueModel(
                        name: docInfo.speciality ?? '',
                        value: docInfo.speciality ?? '');
                  }
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
                                doctorName = value;
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
                            focusNode: doctorRegNumberFocusNode,
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
                            placeholder: 'Speciality',
                            controller: _doctorTypeController,
                            dropDownOption: const [
                              DropDownOption(
                                  name: "Cardiologist", value: "value"),
                              DropDownOption(
                                  name: "Gastroenterologist", value: "value"),
                              DropDownOption(
                                  name: "Pediatrician", value: "value"),
                              DropDownOption(
                                  name: "Psychiatrist", value: "value"),
                              DropDownOption(
                                  name: "Dermatologist", value: "value"),
                              DropDownOption(
                                  name: "Neurologist", value: "value"),
                              DropDownOption(name: "Dentist", value: "value")
                            ],
                            readonly: state is DoctorSelectedState &&
                                state.doctorDetails['speciality']
                                    .toString()
                                    .isNotEmpty,
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
                              isCapitalized: true,
                              label: 'Address Line 1',
                              controller: _addressLine1Controller,
                              readOnly: state is DoctorSelectedState,
                              onChanged: (_) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFieldWidget(
                              label: 'Address Line 2',
                              isCapitalized: true,
                              controller: _addressLine2Controller,
                              readOnly: state is DoctorSelectedState,
                              onChanged: (_) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }),
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
                                    isCapitalized: true,
                                    readOnly: state is DoctorSelectedState,
                                    // formKey: _formKey,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter City";
                                      }
                                      return null;
                                    },
                                    onChanged: (_) {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFieldWidget(
                                    label: 'Pincode',
                                    controller: _pincodeController,
                                    readOnly: state is DoctorSelectedState,
                                    inputType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !value
                                              .contains(RegExp(r'^[0-9]+$')) ||
                                          value.length != 6) {
                                        return "Please enter valid Pincode";
                                      }
                                      return null;
                                    },
                                    onChanged: (_) {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }),
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
                                    isCapitalized: true,
                                    controller: _regionController,
                                    readOnly: state is DoctorSelectedState,
                                    onChanged: (_) {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }),
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
                        state is DoctorSelectedState &&
                                state.doctorDetails['associatedMedicals']
                                    is List &&
                                state.doctorDetails['associatedMedicals']
                                    .isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: _medicalRecords(
                                    state.doctorDetails["associatedMedicals"],
                                    (updatedMedicals) {
                                  setState(() {
                                    state.doctorDetails["associatedMedicals"] =
                                        updatedMedicals;

                                    medicalStoreDetails = updatedMedicals
                                        .map((e) =>
                                            MedicalStoreModel.fromJson(e))
                                        .toList();
                                    doctorDetails.associatedMedicals =
                                        medicalStoreDetails;
                                  });
                                }))
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: MedicalStoreDetailsWidget(
                                  initialStores: initialStores,
                                  onChanged: (List<MedicalStoreModel>
                                      medicalStoreDetail) {
                                    medicalStoreDetails = medicalStoreDetail;
                                  },
                                ),
                              ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          textColor: const Color.fromARGB(255, 65, 81, 90),
                          titleTextStyle: lisTitleStyle,
                          title: const Text('Products',
                              style: TextStyle(fontSize: 30)),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: ProductSelectionWidget(
                              onOptionSelected: (value) {
                                products = value;
                              },
                            )),
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
                              onChanged: (_) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }),
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          currentPosition = await geolocatorUtil
                                              .checkLocationServices(context);
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
                                                _regionController.text
                                                    .toString();
                                            addressInfo.state = _stateController
                                                .dropDownValue?.name
                                                .toString();
                                            doctorDetails.name = doctorName;
                                            doctorDetails.addressInfo =
                                                addressInfo;

                                            doctorDetails.speciality =
                                                _doctorTypeController
                                                    .dropDownValue?.name
                                                    .toString();
                                            doctorDetails.associatedMedicals =
                                                medicalStoreDetails;
                                            doctorDetails.locationCoordinates
                                                ?.add(
                                                    currentPosition.longitude);
                                            doctorDetails.locationCoordinates
                                                ?.add(currentPosition.latitude);
                                            visitModel.doctorInfo =
                                                doctorDetails;
                                            visitModel.products = products;
                                          } else if (state
                                              is DoctorSelectedState) {
                                            final medicals = doctorDetails
                                                .associatedMedicals;
                                            final newMedicals =
                                                medicalStoreDetails
                                                    .where((element) =>
                                                        !medicals!.any(
                                                            (existingMedical) =>
                                                                existingMedical
                                                                    .name ==
                                                                element.name))
                                                    .toList();
                                            doctorDetails.associatedMedicals!
                                                .addAll(newMedicals);
                                            visitModel.doctorInfo =
                                                doctorDetails;
                                            doctorDetails.speciality =
                                                _doctorTypeController
                                                    .dropDownValue?.name
                                                    .toString();
                                          }
                                          visitModel.feedback =
                                              _feedBackController.text;

                                          if (selectedImage!.path != '') {
                                            filePath = selectedImage!.path;
                                          }

                                          if (!_validateLocation()) {
                                            altertUtil
                                                .showWarningAlert(context);
                                          } else {
                                            BlocProvider.of<MasterBloc>(context)
                                                .add(
                                              SaveMasterDataEvent(
                                                  visitModel: visitModel,
                                                  filePath: filePath),
                                            );
                                          }
                                        } catch (e) {
                                          debugPrint("ERROR inside catch $e");
                                        }
                                      } else {
                                        debugPrint('inside else');
                                        if (_doctRegNumberController
                                            .text.isEmpty) {
                                          debugPrint('inside if');
                                          doctorRegNumberFocusNode
                                              .requestFocus();
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please fill all details')));
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

  @override
  void dispose() {
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _regionController.dispose();
    _doctRegNumberController.dispose();
    _feedBackController.dispose();
    _doctorTypeController.dispose();
    _stateController.dispose();

    super.dispose();
  }

  bool _validateLocation() {
    // Used Haversine Distance formula
    // https://medium.com/@abdurrehman-520/unlock-the-power-of-geofencing-in-flutter-with-haversine-formula-21b8203b1a5
    double mrLongitude = currentPosition.longitude;
    double mrLatitude = currentPosition.latitude;

    double doctorLongitude = 73.130581;
    // doctorDetails.locationCoordinates?.elementAt(0) ??
    // currentPosition.longitude;
    double doctorLatitude = 73.130581;
    // doctorDetails.locationCoordinates?.elementAt(1) ??
    // currentPosition.latitude;

    var R = 6371e3; // metres
    // var R = 1000;
    var phi1 = (mrLatitude * pi) / 180; // φ, λ in radians
    var phi2 = (doctorLatitude * pi) / 180;
    var deltaPhi = ((doctorLatitude - mrLatitude) * pi) / 180;
    var deltaLambda = ((doctorLongitude - mrLongitude) * pi) / 180;

    var a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    var d = R * c; // in metres

    debugPrint("Haversine Distance calculated is $d meters");

    return d < 15.0;
    // return false;
  }

  Widget _medicalRecords(
      List<dynamic> meds, Function(List<dynamic>) updateMedicalsCallback) {
    List<MedicalStoreModel> medicals = meds.map((med) {
      return MedicalStoreModel.fromJson(med);
    }).toList();
    const headers = ["Name", "Location", "GST Number"];

    List<DataColumn> getHeaders(List<String> headers) {
      return headers.map((header) {
        return DataColumn(
          label: Text(header, textAlign: TextAlign.center),
        );
      }).toList();
    }

    Future<void> editName(MedicalStoreModel medical) async {
      final name = await showTextDialog(context,
          title: 'Edit Name', value: medical.name ?? '');
      setState(() {
        medicals = medicals.map((m) {
          if (m == medical) {
            debugPrint("inside if with name => $name");
            MedicalStoreModel t = m.copyWith(name: name);
            return t;
          }
          return m;
        }).toList();

        final updatedMedical = medicals.map((e) {
          return e.toJson();
        }).toList();

        updateMedicalsCallback(updatedMedical);
      });
    }

    List<DataRow> getRows(List<MedicalStoreModel> medicals) {
      return medicals.map((medical) {
        final cells = [
          medical.name ?? '-',
          medical.location ?? '-',
          medical.gstNumber ?? '-'
        ];

        return DataRow(
            cells: ModelBuilder.modelBuilder(cells, (index, cell) {
          return DataCell(Text(cell), onTap: () async {
            switch (index) {
              case 0:
                await editName(medical);
                break;
              default:
            }
          });
        }));
      }).toList();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: getHeaders(headers),
        rows: getRows(medicals),
      ),
    );
  }
}

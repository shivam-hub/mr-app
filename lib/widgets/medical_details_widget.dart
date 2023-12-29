import 'package:flutter/material.dart';
import '../models/MedicalStoreModel.dart';
import '../themes/app_colors.dart';

class MedicalStoreDetailsWidget extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const MedicalStoreDetailsWidget(Key? key, this.formKey) : super(key: key);
  @override
  MedicalStoreDetailsWidgetState createState() =>
      MedicalStoreDetailsWidgetState();
}

class MedicalStoreDetailsWidgetState extends State<MedicalStoreDetailsWidget> {
  List<MedicalStoreModel> medicalStores = [MedicalStoreModel()];

  List<MedicalStoreModel> getMedicalStoreDetails() {
    return medicalStores;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < medicalStores.length; index++)
          buildMedicalStoreDetails(index),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  medicalStores.add(MedicalStoreModel());
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 217, 208, 208),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Add Store',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildMedicalStoreDetails(int index) {
    return GestureDetector(
      onTap: () {
        // You can implement custom behavior here when tapped.
        // For now, let's remove the medical store on tap.
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 243, 245),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFF7882A4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Medical Store ${index + 1}',
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Medical Name";
                }
                return null;
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent, // Transparent to see the shadow
                labelText: 'Name',

                floatingLabelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 83, 69, 116)), // Change label text color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF7882A4)), // Change underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Color(0xFF7882A4)), // Change focused underline color
                ),
              ),
              onChanged: (value) {
                if (widget.formKey != null &&
                    widget.formKey!.currentState != null) {
                  widget.formKey!.currentState!.validate();
                }
                setState(() {
                  medicalStores[index].name = value;
                });
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Location";
                }
                return null;
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent, // Transparent to see the shadow
                labelText: 'Location',

                floatingLabelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 83, 69, 116)), // Change label text color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF7882A4)), // Change underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Color(0xFF7882A4)), // Change focused underline color
                ),
              ),
              onChanged: (value) {
                if (widget.formKey != null &&
                    widget.formKey!.currentState != null) {
                  widget.formKey!.currentState!.validate();
                }
                setState(() {
                  medicalStores[index].location = value;
                });
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter GST Number";
                }
                return null;
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent, // Transparent to see the shadow
                labelText: 'GST Number',

                floatingLabelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 83, 69, 116)), // Change label text color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF7882A4)), // Change underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          Color(0xFF7882A4)), // Change focused underline color
                ),
              ),
              onChanged: (value) {
                if (widget.formKey != null &&
                    widget.formKey!.currentState != null) {
                  widget.formKey!.currentState!.validate();
                }
                setState(() {
                  medicalStores[index].gstNumber = value;
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

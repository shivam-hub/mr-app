import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class MedicalStoreDetailsWidget extends StatefulWidget {
  @override
  _MedicalStoreDetailsWidgetState createState() =>
      _MedicalStoreDetailsWidgetState();
}

class _MedicalStoreDetailsWidgetState extends State<MedicalStoreDetailsWidget> {
  List<MedicalStoreDetails> medicalStores = [MedicalStoreDetails()];

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
                  medicalStores.add(MedicalStoreDetails());
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 217, 208, 208),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Add Store',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
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
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 235, 216),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.textFieldBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Medical Store ${index + 1}',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 224, 223, 208),
                labelText: 'Name',
                floatingLabelStyle: TextStyle(color: Colors.brown),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  medicalStores[index].name = value;
                });
              },
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 224, 223, 208),
                labelText: 'Location',
                floatingLabelStyle: TextStyle(color: Colors.brown),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  medicalStores[index].location = value;
                });
              },
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 224, 223, 208),
                labelText: 'GST Number',
                floatingLabelStyle: TextStyle(color: Colors.brown),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: const Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  medicalStores[index].gpsNumber = value;
                });
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class MedicalStoreDetails {
  String name = '';
  String location = '';
  String gpsNumber = '';
}

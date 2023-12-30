import 'package:flutter/material.dart';
import '../models/medical_store_model.dart';
import '../themes/app_colors.dart';

class MedicalStoreDetailsWidget extends StatefulWidget {
  final Function(List<MedicalStoreModel>)? onChanged;
  const MedicalStoreDetailsWidget({super.key, this.onChanged});
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
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 224, 223, 208),
                labelText: 'Name',
                floatingLabelStyle: const TextStyle(color: Colors.brown),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  medicalStores[index].name = value;
                  widget.onChanged!(medicalStores);
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
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 224, 223, 208),
                labelText: 'Location',
                floatingLabelStyle: const TextStyle(color: Colors.brown),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  medicalStores[index].location = value;
                  widget.onChanged!(medicalStores);
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
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 224, 223, 208),
                labelText: 'GST Number',
                floatingLabelStyle: const TextStyle(color: Colors.brown),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 237, 235, 216),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  medicalStores[index].gstNumber = value;
                  widget.onChanged!(medicalStores);
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

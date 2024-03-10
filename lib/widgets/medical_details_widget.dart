import 'package:Nurene/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/medical_store_model.dart';

class MedicalStoreDetailsWidget extends StatefulWidget {
  final List<MedicalStoreModel>? initialStores;
  final Function(List<MedicalStoreModel>)? onChanged;
  const MedicalStoreDetailsWidget(
      {super.key, this.onChanged, this.initialStores});
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
  void initState() {
    super.initState();
    if (widget.initialStores != null && widget.initialStores!.isNotEmpty) {
      medicalStores = widget.initialStores!;
    }
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
                backgroundColor: AppColors.appThemeLightShade1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Add Store',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
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
        setState(() {
          // medicalStores.removeAt(index);
          widget.onChanged!(medicalStores);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.appThemeDarkShade2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Medical Store ${index + 1}',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          medicalStores.removeAt(index);
                          widget.onChanged!(medicalStores);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              style: GoogleFonts.montserrat(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter Medical Name";
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelStyle: GoogleFonts.montserrat(),
                fillColor: Colors.transparent,
                labelText: 'Name',
                floatingLabelStyle: GoogleFonts.montserrat(
                  color: AppColors.appThemeDarkShade1,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appThemeDarkShade1,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appThemeDarkShade1,
                    style: BorderStyle.solid,
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
                labelStyle: GoogleFonts.montserrat(),
                filled: true,
                fillColor: Colors.transparent,
                labelText: 'Location',
                floatingLabelStyle: GoogleFonts.montserrat(
                  color: AppColors.appThemeDarkShade1,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appThemeDarkShade1,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appThemeDarkShade1,
                    style: BorderStyle.solid,
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
              decoration: InputDecoration(
                labelStyle: GoogleFonts.montserrat(),
                filled: true,
                fillColor: Colors.transparent,
                labelText: 'GST Number',
                floatingLabelStyle: GoogleFonts.montserrat(
                  color: AppColors.appThemeDarkShade1,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appThemeDarkShade1,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appThemeDarkShade1,
                    style: BorderStyle.solid,
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

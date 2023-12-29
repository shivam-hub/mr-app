import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurene_app/themes/app_colors.dart';

class PickImage extends StatefulWidget {
  final Function(File?) onImageSelected;

  const PickImage({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  XFile? selectedImage;

  Future<void> _selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);

    setState(() {
      selectedImage = file;
    });

    // Pass the selected image to the parent widget
    widget.onImageSelected(File(file!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF7882A4),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 244, 243, 245),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: AppColors.textFieldBorderColor,
                    ),
                    InkWell(
                      onTap: () async {
                        _selectImageFromCamera();
                      },
                      child: Container(
                        //padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 244, 243, 245),
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
                                color: AppColors.textFieldBorderColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Tap to open your camera',
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
              const VerticalDivider(
                color: Colors.grey,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              selectedImage != null
                  ? Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Image.file(
                            File(selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.cancel_rounded,
                                color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                selectedImage = null;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : const Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Icon(
                        Icons.image_outlined,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

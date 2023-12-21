import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

String selectedImagePath = '';

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.image),
    );
  }
}

Future selectImage(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    'Select Image From !',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath = await selectImageFromCamera();
                          print('Image_Path:-');
                          print(selectedImagePath);

                          if (selectedImagePath != '') {
                            Navigator.pop(context);
                            // setState(() {});
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("No Image Captured !"),
                            ));
                          }
                        },
                        child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'asset/images/camera.jpg',
                                    height: 60,
                                    width: 60,
                                  ),
                                  const Text('Camera'),
                                ],
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

selectImageFromGallery() async {
  XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 10);
  if (file != null) {
    return file.path;
  } else {
    return '';
  }
}

//
selectImageFromCamera() async {
  XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 10);
  if (file != null) {
    return file.path;
  } else {
    return '';
  }
}

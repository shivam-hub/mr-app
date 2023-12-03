import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showImagePickerOption(context);
      },
      icon: const Icon(Icons.image),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 236, 232, 185),
        context: context,
        builder: (builder) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: InkWell(
              onTap: (){},
              child:const SizedBox(
                child: Column(
                  children: [Icon(Icons.camera_alt_rounded, size: 100,), Text("Open Your Camera")]
                ),)
            ),
          );
        });
  }
}

import 'dart:io';

import 'package:camara_test/screen/ChooseCategory.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/CamScreen.dart';
import '../screen/MoviesScreen.dart';

class Button extends StatefulWidget {
  // const Button({super.key});

  // File ? _selectedImage;

  final String btnText;

  const Button({
    Key? key,
    required this.btnText,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState(btnText);
}

class _ButtonState extends State<Button> {
  final String btnText;

  _ButtonState(this.btnText);

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // camara picker load
        // _pickImageFromCamera();
        // debugPrint(pickImageFromCamara);

        // await Navigator.push(
        //    context,
        //    MaterialPageRoute(builder: (context) => ChooseCategory(mood: "Happy"),)
        //  );
        try {
          await availableCameras().then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CamScreen(
                  cameras: value,
                ),
              ),
            ),
          );
          Navigator.of(context).pop();
        } catch (e) {}
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 164, 21, 230),
                  Color.fromARGB(255, 91, 54, 136)
                ]),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 250,
          height: 60,
          alignment: Alignment.center,
          child: Text(
            btnText,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Future _pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;
    setState(() {
      _selectedImage = File(image!.path);
    });
  }
}

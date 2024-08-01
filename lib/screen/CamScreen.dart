import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ChooseCategory.dart';

class CamScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CamScreen({
    super.key,
    required this.cameras,
  });

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late CameraController controller;
  late final XFile? pictureFile;
  String? message = "";
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
      enableAudio: false,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 20),
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CameraLayout(context),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CameraButton(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _CameraLayout(BuildContext context) {
    try {
      return Container(
        height: 650,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: AspectRatio(
          aspectRatio: 1 / controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      );
    } catch (e) {}

    return Container(
      height: 650,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _CameraButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await sendImageForPrediction();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseCategory(
                mood: message,
              ),
            ));
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 50, 48, 57),
                  Color.fromARGB(255, 53, 53, 56)
                ]),
            borderRadius: BorderRadius.circular(200)),
        child: Container(
          width: 75,
          height: 75,
          alignment: Alignment.center,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera,
                size: 50,
              ),
            ],
          ),
          // child: Text(
          //   btnText,
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          // ),
        ),
      ),
    );
  }

  Future<void> sendImageForPrediction() async {
    try {
      final XFile file = await controller.takePicture();
      setState(() {
        pictureFile = file;
      });

      // Convert image to base64
      List<int> imageBytes = await file.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      // print(base64Image);

      var body = jsonEncode({'image': base64Image});
      var url = 'http://localhost:5000/predict';
      var headers = {'Content-Type': 'application/json'};

      try {
        var response =
            await http.post(Uri.parse(url), headers: headers, body: body);
        if (response.statusCode == 200) {
          // Successful response
          print('Response: ${response.body}');

          final resJson = jsonDecode(response.body);
          message = resJson['emotion'];
        } else {
          // Error in response
          print('Error: ${response.reasonPhrase}');
        }
      } catch (e) {
        // Exception during request
        print('Exception: $e');
      }
    } catch (e) {
      print(e);
    }
  }
}

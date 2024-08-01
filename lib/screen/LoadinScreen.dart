import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'ChooseCategory.dart';

class LoadingScreen extends StatefulWidget {
  final image;
  const LoadingScreen({super.key, this.image});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? message = "";
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  load(BuildContext context) async {
    print(widget.image);

    await sendImageForPrediction();

    print(message);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ChooseCategory(
    //         mood: message,
    //       ),
    //     ));

    navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => ChooseCategory(mood: message)),
    );
  }

  Future<void> sendImageForPrediction() async {
    try {
      var body = jsonEncode({'image': widget.image});
      // var url = 'http://192.168.1.168:5000/predict';
      var url = 'http://192.168.1.168:5000/predict';
      // http://127.0.0.1:5000
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

  @override
  Widget build(BuildContext context) {
    load(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 194, 123, 226),
                    Color.fromARGB(255, 76, 44, 116),
                    Color.fromARGB(255, 23, 16, 30)
                  ]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/Spinner-1s-200px (1).gif"),
              Text(
                "Place Wait to Prediction",
                overflow: TextOverflow.clip,
                softWrap: true, // This ensures the text wraps
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Image.asset("assets/pu0vketf9qq51.png", width: double.infinity),
            ],
          ),
        )),
      ),
    );
  }
}

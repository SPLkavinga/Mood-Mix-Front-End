import 'dart:convert';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SongScreen extends StatelessWidget {
  final List<dynamic> data;

  const SongScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 26, 26),
        body: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 47, 34, 54),
                    Color.fromARGB(255, 76, 44, 116),
                    Color.fromARGB(255, 107, 20, 178)
                  ]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    textAlign: TextAlign.left,
                    'Best Of Song Collection',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 30,
                          height: 2,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 30),
                  child: Text(
                    textAlign: TextAlign.left,
                    'We Are Choosing a Best Of Songs Collection For You This Song can change your mood always stay happy and have a nice day',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),

                Container(
                  height: .75 * MediaQuery.of(context).size.height,
                  width: double.maxFinite,
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8.0, // spacing between adjacent chips
                      runSpacing: 8.0, // spacing between lines of chips

                      children: List.generate(data.length, (index) {
                        return SongsBox(
                            context,
                            data[index]['title'],
                            data[index]['genre'],
                            data[index]['mood'],
                            data[index]['whyThisMood'],
                            data[index]['artist'],
                            data[index]['link']);
                      }),
                    ),
                  ),
                ),

                // SizedBox(height: 350, child: Image.asset("assets/cat.png"))
              ]),
        ),
      ),
    );
  }

  Widget SongsBox(BuildContext context, String title, String gen, String mood,
      String description, String artist, String url) {
    return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 47, 34, 54),
                  Color.fromARGB(255, 76, 44, 116),
                  Color.fromARGB(255, 107, 20, 178)
                ]),
            borderRadius: BorderRadius.circular(20)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(15),
              // backgroundColor: Color.fromRGBO(159, 84, 241, 0.6980392156862745),
              backgroundColor: Colors.transparent),
          onPressed: () async {
            _launchUrl(url);
          },
          child: Row(
            children: [
              Image.asset("SongIconSpotify.png", width: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        '  [ $gen ]',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        artist,
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        description,
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _launchUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  Future<void> loadJsonData() async {
    String jsonData = await rootBundle.loadString('assets/MovieHappy.json');
    List<dynamic> data = jsonDecode(jsonData);
    // for (var movie in data) {
    //   print(movie['title']);
    // }
  }
}

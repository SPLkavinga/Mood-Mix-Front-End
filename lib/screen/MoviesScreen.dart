import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviesScreen extends StatelessWidget {
  final List<dynamic> data;

  const MoviesScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 26, 26),
        body: Container(
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
                    'Best Of Movie Collection',
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
                    'We Are Choosing a Best Of Movie Collection For You This movies can change your mood always stay happy and have a nice day',
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
                  padding: EdgeInsets.zero,
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: List.generate(data.length, (index) {
                        return moviesBox(
                            data[index]['url'],
                            data[index]['title'],
                            data[index]['release_date'],
                            context);
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

  Widget moviesBox(String url, String name, String date, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
      width: .50 * MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            backgroundColor: Colors.black54,
          ),
          onPressed: () async {
            _launchUrl(url);
          },
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset("assets/movieImg/$name.jpg"),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    name,
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    date,
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 10,
                          height: 2,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
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

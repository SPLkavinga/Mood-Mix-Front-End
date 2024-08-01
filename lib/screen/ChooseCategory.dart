import 'dart:convert';

import 'package:camara_test/screen/MoviesScreen.dart';
import 'package:camara_test/screen/SongScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseCategory extends StatelessWidget {
  final mood;

  const ChooseCategory({super.key, this.mood});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
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
                    'Choose A Category',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Text(
                    textAlign: TextAlign.left,
                    'Choose A Category to mood fix with your Like music or Movies ',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                spotifyButton(getMusic(mood), context),
                movieButton(getMovie(mood), context),
                const Spacer(
                  flex: 1,
                ),
                const Spacer(
                  flex: 2,
                ),
                // SizedBox(height: 350, child: Image.asset("assets/cat.png"))
              ]),
        ),
      ),
    ));
  }

  Widget spotifyButton(String url, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.zero,
            backgroundColor: Colors.black54,
          ),
          onPressed: () async {
            try {
              await fetchSongData(mood).then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongScreen(data: value),
                  ),
                ),
              );
              Navigator.of(context).pop();
            } catch (e) {}
          },
          child: Container(
              width: double.infinity,
              // padding: EdgeInsets.all(40),
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("assets/spotify.jpg"),
              ))),
    );
  }

  Future<String> loadSongJsonData(String mood) async {
    return await rootBundle.loadString(getMusic(mood));
  }

  Future<List<dynamic>> fetchSongData(String mood) async {
    String jsonData = await loadSongJsonData(mood);
    List<dynamic> data = jsonDecode(jsonData);
    return data;
  }

  getMusic(String mood) {
    switch (mood) {
      case 'Happy':
        return "assets/SongHappy.json";
      case 'Sad':
        return "assets/SongSad.json";
      case 'Neutral':
        return "assets/SongNeutra.json";
      case 'Angry':
        return "assets/SongAngry.json";
      default:
        return null;
    }
  }

  Widget movieButton(String movieURL, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.zero,
            backgroundColor: Colors.black54,
          ),
          onPressed: () async {
            try {
              await fetchMovieData(mood).then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviesScreen(data: value),
                  ),
                ),
              );
              Navigator.of(context).pop();
            } catch (e) {}
          },
          child: Container(
              width: double.infinity,
              // padding: EdgeInsets.all(40),
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("assets/movies.png"),
              ))),
    );
  }

  Future<String> loadMovieJsonData(String mood) async {
    return await rootBundle.loadString(getMovie(mood));
  }

  Future<List<dynamic>> fetchMovieData(String mood) async {
    String jsonData = await loadMovieJsonData(mood);
    List<dynamic> data = jsonDecode(jsonData);
    return data;
  }

  getMovie(String mood) {
    switch (mood) {
      case 'Happy':
        return "assets/MovieHappy.json";
      case 'Sad':
        return "assets/MovieSad.json";
      case 'Neutral':
        return "assets/MovieNeutral.json";
      case 'Angry':
        return "assets/MovieAngry.json";
      default:
        return null;
    }
  }
}

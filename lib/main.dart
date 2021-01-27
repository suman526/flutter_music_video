import 'package:flutter/material.dart';
import 'package:task1_app/audio.dart';
import 'package:task1_app/home.dart';
import 'package:task1_app/tracks.dart';
import 'package:task1_app/video.dart';
//import 'package:task1_app/video.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      //home:Myhome(),
      initialRoute: "/",
      routes: {
        "/": (context) => Myhome(),
        "/audio": (context) => Myaudio(),
        "/video": (context) => VideoPlayerScreen(),
        "/tracks": (context) => Tracks(),
      }
      ),
      );
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class Myaudio extends StatefulWidget {
  _MyaudioState createState() => _MyaudioState();
  SongInfo songInfo;
  Function changeTrack;
  final GlobalKey<_MyaudioState> key;
  Myaudio({this.songInfo,this.changeTrack,this.key}):super(key:key);
}

class _MyaudioState extends State<Myaudio> {
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying=false;
  final AudioPlayer player = AudioPlayer();
  void initState() {
    super.initState();
    setSong(widget.songInfo);
  }
  void dispose(){
    super.dispose();
    player?.dispose();
  }

  void setSong(SongInfo songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri);
    currentValue=minimumValue;
    maximumValue=player.duration.inMilliseconds.toDouble();
    setState(() {
      currentTime=getDuration(currentValue);
      endTime=getDuration(maximumValue);
    });
    isPlaying=false;
    changeStatus();
    player.positionStream.listen((duration) { 
       currentValue=duration.inMilliseconds.toDouble();
      setState(() {
        currentTime=getDuration(currentValue);
      });
    });
  }
  void changeStatus(){
    setState(() {
      isPlaying=!isPlaying;
    });
    if(isPlaying) {
      player.play();
    } else  {
      player.pause();
    }
  }
  String getDuration(double value)  {
    Duration duration=Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds].map((element)=>element.remainder(60).toString().padLeft(2, '0')).join(':');
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NOW PLAYING",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 36,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 26.0,
                  ),
                )),
          ],
          actionsIconTheme:
              IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
          backgroundColor: Colors.purple[200],
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 6, 0),
          decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://png.pngtree.com/thumb_back/fw800/back_our/20190617/ourmid/pngtree-abstract-staff-color-musical-notes-music-festival-background-material-image_124956.jpg"),
                      fit: BoxFit.cover,
           ),
           boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent,
                        spreadRadius: 20,
                        blurRadius: 100,
                        offset: Offset(0, 0),
                      ),]
            ),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: widget.songInfo.albumArtwork == null
                    ? NetworkImage('https://www.connollymusic.com/hubfs/What-Is-A-Music-Therapist-How-Do-I-Become-One-Index.jpg')
                    : FileImage(File(widget.songInfo.albumArtwork)),
                radius: 90,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 5, 7),
                child: Text(
                  widget.songInfo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text(
                  widget.songInfo.artist,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 15.0),
                ),
              ),
              Slider(
                inactiveColor: Colors.black,
                activeColor: Colors.redAccent,
                min: minimumValue,max: maximumValue,value: currentValue,
                onChanged: (value) {
  currentValue=value;
  player.seek(Duration(milliseconds: currentValue.round()));
},
),
              Container(transform: Matrix4.translationValues(0, -15, 0),margin: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                 Text(currentTime, style: TextStyle(color: Colors.grey, fontSize: 12.5, fontWeight: FontWeight.w500)),
                        Text(endTime, style: TextStyle(color: Colors.grey, fontSize: 12.5, fontWeight: FontWeight.w500))
                              ],)),
              Container(
                   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                   GestureDetector(child: Icon(Icons.skip_previous,
                                   color: Colors.black, size: 55),
                                   behavior: HitTestBehavior.translucent,
                                   onTap: () {
                                    widget.changeTrack(false);
                                  },),
   GestureDetector(child: Icon(isPlaying?Icons.pause_circle_filled:Icons.pause_circle_filled, 
      color: Colors.black, 
      size: 85),
      behavior: HitTestBehavior.translucent, 
      onTap: () {
      changeStatus();
    },),
  GestureDetector(child: Icon(Icons.skip_next, 
  color: Colors.black, 
  size: 55),
   behavior: HitTestBehavior.translucent,
   onTap: () {
    widget.changeTrack(true);
 },),
]),
)])));
  }
}

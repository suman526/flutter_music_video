import 'package:flutter/material.dart';

class Myhome extends StatefulWidget {
  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          child: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink,
                            spreadRadius: 40,
                            blurRadius: 100,
                            offset: Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(300, 80),
                          bottomRight: Radius.elliptical(300, 80),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink.shade100,
                            Colors.blueAccent.shade100,
                          ],
                        )),
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "WORLD OF MUSIC",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //SizedBox(
              //height: 35,
              //),

              Container(
                margin: EdgeInsets.all(30),
                width: 200,
                height: 100,
                child: RaisedButton(
                  onPressed: () => {Navigator.pushNamed(context, "/tracks")},
                  color: Colors.blue[300],
                  child: Text("MUSIC",
                      style: TextStyle(
                        color: Colors.indigo,
                        decorationStyle: TextDecorationStyle.wavy,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              new MaterialButton(
                height: 100.0,
                minWidth: 200.0,
                color: Theme.of(context).backgroundColor,
                textColor: Colors.indigoAccent,
                child: new Text("VIDEO",
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'hind'
                ),),
                //textTheme:new TextTheme({ headline:
                  //    TextStyle(fontSize: 25, fontStyle: FontStyle.italic)
                //}),
                onPressed: () => {Navigator.pushNamed(context, "/video")},
                splashColor: Colors.redAccent,
              ),
            ],
          ),
        )));
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GestureDetectorDemo(title: 'GestureDetector & InkWell'),
    );
  }
}

GestureDetectorDemoState pageState;

class GestureDetectorDemo extends StatefulWidget {
  GestureDetectorDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GestureDetectorDemoState createState() {
    pageState = GestureDetectorDemoState();
    return pageState;
  }
}

class GestureDetectorDemoState extends State<GestureDetectorDemo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          myTitle("InkWell"),
          InkWell(
            child: Container(
              height: 50,
              color: Colors.orange,
              alignment: Alignment(0, 0),
              margin: const EdgeInsets.all(10),
              child: Text(
                "Container with Text in InkWell\nTap me!!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              showSnackBar("InkWell - onTap");
            },
            onDoubleTap: () {
              showSnackBar("InkWell - onDoubleTap");
            },
            onTapDown: (value) {
              showSnackBar("InkWell - onTapDown");
            },
            onTapCancel: () {
              showSnackBar("InkWell - onTapCancel");
            },
            onLongPress: () {
              showSnackBar("InkWell - onLongPress");
            },
          ),
          myTitle("Gesture Detector"),
          GestureDetector(
            child: Container(
              height: 50,
              color: Colors.blue,
              alignment: Alignment(0, 0),
              margin: const EdgeInsets.all(10),
              child: Text(
                "Container with Text in GestureDetector\nTap me!!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              showSnackBar("GestureDetector - onTap");
            },
            onDoubleTap: () {
              showSnackBar("GestureDetector - onDoubleTap");
            },
            onTapDown: (value) {
              showSnackBar("GestureDetector - onTapDown");
            },
            onTapCancel: () {
              showSnackBar("GestureDetector - onTapCancel");
            },
            onLongPress: () {
              showSnackBar("GestureDetector - onLongPress");
            },
          ),
        ],
      ),
    );
  }

  myTitle(String title) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-1, 0),
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Text(
            "* $title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }

  showSnackBar(String message) {
    scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.blue,
            action: SnackBarAction(
              label: "Done",
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
  }
}
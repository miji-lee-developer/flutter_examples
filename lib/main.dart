import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: ParseJsonDemo(title: 'Parse Json Data'),
    );
  }
}

ParseJsonDemoState pageState;

class ParseJsonDemo extends StatefulWidget {
  ParseJsonDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ParseJsonDemoState createState() {
    pageState = ParseJsonDemoState();
    return pageState;
  }
}

class ParseJsonDemoState extends State<ParseJsonDemo> {
  String filePath = "assets/files/albums.json"; // Json File
  String fileText = ""; // String to store Json Data
  List<Album> albums = List<Album>(); // List to store Parsed Json Data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Text("File Info: "),
                Container(width: 10),
                Expanded(child: customTextContainer(filePath)),
                Container(width: 10),
                customButton("Read", () { readFile(); }),
              ],
            ),
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  fileText,
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Parse Json File String to Albums"),
                customButton(
                  "parse",
                  (fileText.length > 0)
                  ? () { parseJson(); }
                  : null
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: ListView.builder(
                itemCount: albums.length,
                itemBuilder: (Context, index) {
                  Album album = albums[index];
                  return Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                customBoxContainer(Text("userID: "), left: true, top: true, right: true),
                                customBoxContainer(Text(album.userId.toString()), top: true, right: true),
                                customBoxContainer(Text("id: "), top: true, right: true),
                                customBoxContainer(Text(album.id.toString()), top: true, right: true),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                customBoxContainer(Text("title: "), left: true, top: true, bottom: true),
                                customBoxContainer(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    album.title,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                left: true, top: true, right: true, bottom: true, flex: 4)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  readFile() async {
    String text = await rootBundle.loadString(filePath);
    setState(() {
      fileText = text;
    });
  }

  parseJson() {
    final parsed = json.decode(fileText).cast<Map<String, dynamic>>();
    setState(() {
      albums = parsed.map<Album>((json) => Album.fromJson(json)).toList();
    });
  }

  customBoxContainer(Widget child,
      {bool left = false,
        bool top = false,
        bool right = false,
        bool bottom = false,
        int flex = 1}) {
    BorderSide borderSide = BorderSide(color: Colors.grey[500], width: 1);
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: (left == true) ? borderSide : BorderSide.none,
            top: (top == true) ? borderSide : BorderSide.none,
            right: (right == true) ? borderSide : BorderSide.none,
            bottom: (bottom == true) ? borderSide : BorderSide.none,
          ),
        ),
        alignment: Alignment(0, 0),
        child: child,
      ),
    );
  }

  customTextContainer(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text),
    );
  }

  customButton(String text, Null Function() onPressed) {
    return SizedBox(
      height: 30,
      width: 60,
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        color: Colors.blue,
        disabledColor: Colors.grey,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(fontSize: 13),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String
    );
  }
}
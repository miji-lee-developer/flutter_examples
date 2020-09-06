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
      home: ReadAssetFile(title: 'Read Asset File'),
    );
  }
}

ReadAssetFileState pageState;

class ReadAssetFile extends StatefulWidget {
  ReadAssetFile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ReadAssetFileState createState() {
    pageState = ReadAssetFileState();
    return pageState;
  }
}

class ReadAssetFileState extends State<ReadAssetFile> {
  String filePath = "assets/files/albums.json";
  String fileText = "";

  readFile() async {
    String text = await rootBundle.loadString(filePath);
    setState(() {
      fileText = text;
    });
  }

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
                Container(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  height: 40,
                  width: 35,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(0),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.refresh,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        fileText = "";
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
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
          ),
        ],
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
      child: Text(text)
    );
  }

  customButton(String text, Null Function() onPressed) {
    return SizedBox(
      height: 30,
      width: 60,
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        color: Colors.blue,
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
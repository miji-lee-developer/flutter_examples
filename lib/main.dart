import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
      home: FileReadWriteDemo(title: 'File I/O'),
    );
  }
}

FileReadWriteDemoState pageState;

class FileReadWriteDemo extends StatefulWidget {
  FileReadWriteDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  FileReadWriteDemoState createState() {
    pageState = FileReadWriteDemoState();
    return pageState;
  }
}

class FileReadWriteDemoState extends State<FileReadWriteDemo> {
  String appDocPath;
  String filePath;
  TextEditingController wCon = TextEditingController();
  TextEditingController rCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    prepareDirPath();
  }

  void prepareDirPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Stream<FileSystemEntity> files = appDocDir.list();

    files.listen((data) {
      print("Data: " + data.toString());
    });

    setState(() {
      appDocPath = appDocDir.path;
      filePath = "$appDocPath/text.txt";
    });
  }

  Future<File> getFileRef() async {
    return File(filePath);
  }

  writeFile() async {
    File file = await getFileRef();
    file.writeAsString(wCon.text);
    wCon.clear();
  }

  readFile() async {
    File file = await getFileRef();
    String text = await file.readAsString();
    rCon.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              prepareDirPath();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          showPathInfo(), writeFileArea(), readFileArea()
        ],
      ),
    );
  }

  Widget showPathInfo() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Documents directory's path"),
            subtitle: (appDocPath != null) ? Text(appDocPath) : null,
          ),
          ListTile(
            title: Text("File name & path"),
            subtitle: (filePath != null) ? Text(filePath) : null,
          ),
        ],
      ),
    );
  }

  writeFileArea() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "* Write File (text.txt)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment(-1, 0),
              ),
              SizedBox(
                height: 30,
                child: RaisedButton(
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  child: Text("Write"),
                  onPressed: () {
                    writeFile();
                  },
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey),
          TextField(
            controller: wCon,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Insert text that you want to write to file",
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: SizedBox(
          //     height: 30,
          //     child: RaisedButton(
          //       color: Colors.orangeAccent,
          //       textColor: Colors.white,
          //       child: Text("Write"),
          //       onPressed: () {
          //         writeFile();
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  readFileArea() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "* Read File (text.txt)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment(-1, 0),
              ),
              SizedBox(
                height: 30,
                child: RaisedButton(
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  child: Text("Read"),
                  onPressed: () {
                    readFile();
                  },
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey,),
          TextField(
            controller: rCon,
            maxLines: 5,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFDBEDFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
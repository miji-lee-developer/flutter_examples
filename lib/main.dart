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
      home: ScreenOrientationsDemo(title: 'AppBar'),
    );
  }
}

ScreenOrientationsDemoState pageState;

class ScreenOrientationsDemo extends StatefulWidget {
  ScreenOrientationsDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ScreenOrientationsDemoState createState() {
    pageState = ScreenOrientationsDemoState();
    return pageState;
  }
}

class ScreenOrientationsDemoState extends State<ScreenOrientationsDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget> [
            Container(
              height: 50,
              color: Colors.orange,
              alignment: Alignment(0, 0),
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Do this example on a real phone, not an emulator.",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("Set All (default)"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                },
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey,
              indent: 70,
              endIndent: 70,
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("DeviceOrientation.landscapes"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                },
              ),
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("DeviceOrientation.portraities"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                },
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey,
              indent: 70,
              endIndent: 70,
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("DeviceOrientation.landscapeRight"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
                },
              ),
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("DeviceOrientation.landscapeLeft"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                },
              ),
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("DeviceOrientation.portraitUp"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                },
              ),
            ),
            Container(
              width: 300,
              child: RaisedButton(
                child: Text("DeviceOrientation.portraitDown"),
                onPressed: () {
                  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
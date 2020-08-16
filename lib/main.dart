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
      home: NaviFirstScreen(title: 'First Screen'),
    );
  }
}

NaviFirstScreenState pageState;

class NaviFirstScreen extends StatefulWidget {
  NaviFirstScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  NaviFirstScreenState createState() {
    pageState = NaviFirstScreenState();
    return pageState;
  }
}

class NaviFirstScreenState extends State<NaviFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70,
              width: 250,
              decoration: BoxDecoration(color: Colors.orange),
              alignment: Alignment(0, 0),
              child: Text(
                "This is the First Screen",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              child: Text("Launch Screen"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NaviSecondScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NaviSecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70,
              width: 250,
              decoration: BoxDecoration(color: Colors.indigoAccent),
              alignment: Alignment(0, 0),
              child: Text(
                "This is the Second Screen",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              child: Text("Go back to First Screen"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: SharedPreferencesDemo(title: 'Shared Preferences Demo'),
    );
  }
}

SharedPreferencesDemoState pageState;

class SharedPreferencesDemo extends StatefulWidget {
  SharedPreferencesDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SharedPreferencesDemoState createState() {
    pageState = SharedPreferencesDemoState();
    return pageState;
  }
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  int counter;

  @override
  void initState() {
    super.initState();
    getCounter();
  }

  getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt("counter") ?? 0);
    });
  }

  setCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("counter", counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: FloatingActionButton(
                heroTag: "remove",
                child: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    counter--;
                  });
                  setCounter();
                },
              ),
            ),
            Text("Shared preferences value: "),
            Text(
              "${counter.toString()}",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 40,
              child: FloatingActionButton(
                heroTag: "add",
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                  setCounter();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt("counter") ?? 0);
    });
  }

  setCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("counter", counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: FloatingActionButton(
                heroTag: "add",
                child: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    counter--;
                  });
                  setCounter();
                },
              ),
            ),
            Text("Shared Preferences value: "),
            Text(
              "${counter.toString()}",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 40,
              child: FloatingActionButton(
                heroTag: "remove",
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                  setCounter();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
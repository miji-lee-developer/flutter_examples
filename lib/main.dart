import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

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
      home: ManageScreenDemo(title: 'Manage Screen Demo'),
    );
  }
}

ManageScreenDemoState pageState;

class ManageScreenDemo extends StatefulWidget {
  ManageScreenDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ManageScreenDemoState createState() {
    pageState = ManageScreenDemoState();
    return pageState;
  }
}

class ManageScreenDemoState extends State<ManageScreenDemo> {
  double _brightness;
  bool _enableKeptOn;

  @override
  void initState() {
    super.initState();
    getBrightness();
    getIsKeptOnScreen();
  }

  void getBrightness() async {
    double value = await Screen.brightness;
    setState(() {
      _brightness = double.parse(value.toStringAsFixed(1));
    });
  }

  void getIsKeptOnScreen() async {
    bool value = await Screen.isKeptOn;
    setState(() {
      _enableKeptOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            alignment: Alignment(0, 0),
            height: 50,
            decoration: BoxDecoration(color: Colors.orange),
            child: Text(
              "Do this example on a real phone, not an emulator.",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Brightness"),
                (_brightness == null)
                  ? CircularProgressIndicator()
                  : Slider(
                    value: _brightness,
                    min: 0,
                    max: 1.0,
                    divisions: 10,
                    onChanged: (newValue) {
                      setState(() {
                        _brightness = newValue;
                      });
                      Screen.setBrightness(_brightness);
                    },
                ),
                Text(_brightness.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Kept on Screen"),
                Text(_enableKeptOn.toString()),
                (_enableKeptOn == null)
                  ? CircularProgressIndicator()
                  : Switch(
                    value: _enableKeptOn,
                    onChanged: (flag) {
                      Screen.keepOn(flag);
                      getIsKeptOnScreen();
                    },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
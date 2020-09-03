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
      home: FitImageDemo(title: 'Fit Image Demo'),
    );
  }
}

FitImageDemoState pageState;

class FitImageDemo extends StatefulWidget {
  FitImageDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  FitImageDemoState createState() {
    pageState = FitImageDemoState();
    return pageState;
  }
}

class FitImageDemoState extends State<FitImageDemo> {
  String imagePath = "assets/images/300by300.jpg";
  double boxHeight = 300;
  double boxWidth = 300;
  BoxFit fit = BoxFit.fill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(top: 25)),
          Center(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.grey[300],
              alignment: Alignment(0, 0),
              child: Image.asset(
                imagePath,
                fit: fit,
                width: boxWidth,
                height: boxHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Image:"),
                RaisedButton(
                  child: Text("300 X 300"),
                  onPressed: () {
                    setState(() {
                      imagePath = "assets/images/300by300.jpg";
                      boxHeight = 300;
                      boxWidth = 300;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("200 X 300"),
                  onPressed: () {
                    setState(() {
                      imagePath = "assets/images/200by300.jpg";
                      boxHeight = 300;
                      boxWidth = 200;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("300 X 200"),
                  onPressed: () {
                    setState(() {
                      imagePath = "assets/images/300by200.jpg";
                      boxHeight = 200;
                      boxWidth = 300;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Box Width:"),
                Slider(
                  value: boxWidth,
                  min: 50,
                  max: 300,
                  divisions: 25,
                  onChanged: (value) {
                    setState(() {
                      boxWidth = value;
                    });
                  },
                ),
                Text(boxWidth.toInt().toString())
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Box Height:"),
                Slider(
                  value: boxHeight,
                  min: 50,
                  max: 300,
                  divisions: 25,
                  onChanged: (value) {
                    setState(() {
                      boxHeight = value;
                    });
                  },
                ),
                Text(boxHeight.toInt().toString())
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Box Fit:"),
                Expanded(child: Container()),
                PopupMenuButton<BoxFit>(
                  onSelected: (BoxFit result) {
                    print(result);
                    setState(() {
                      fit = result;
                    });
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Text(fit.toString()),
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<BoxFit>>[
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.contain,
                      child: Text("BoxFit.contain"),
                    ),
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.cover,
                      child: Text("BoxFit.cover"),
                    ),
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.fill,
                      child: Text("BoxFit.fill"),
                    ),
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.fitHeight,
                      child: Text("BoxFit.fitHeight"),
                    ),
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.fitWidth,
                      child: Text("BoxFit.fitWidth"),
                    ),
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.none,
                      child: Text("BoxFit.none"),
                    ),
                    const PopupMenuItem<BoxFit>(
                      value: BoxFit.scaleDown,
                      child: Text("BoxFit.scaleDown"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
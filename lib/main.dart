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
      home: LoadImageFromAsset(title: 'Load Image From Asset'),
    );
  }
}

LoadImageFromAssetState pageState;

class LoadImageFromAsset extends StatefulWidget {
  LoadImageFromAsset({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoadImageFromAssetState createState() {
    pageState = LoadImageFromAssetState();
    return pageState;
  }
}

class LoadImageFromAssetState extends State<LoadImageFromAsset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset("assets/images/download.jpg"),
          ),
          Text("path: assets/images/download.jpg"),
        ],
      ),
    );
  }
}
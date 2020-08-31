import 'dart:math';
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
      home: LoadImageFromNetwork(title: 'Load Image From Network'),
    );
  }
}

LoadImageFromNetworkState pageState;

class LoadImageFromNetwork extends StatefulWidget {
  LoadImageFromNetwork({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoadImageFromNetworkState createState() {
    pageState = LoadImageFromNetworkState();
    return pageState;
  }
}

class LoadImageFromNetworkState extends State<LoadImageFromNetwork> {
  String url = "https://picsum.photos/300?${Random().nextInt(100)}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.network(url),
          ),
          Text(url),
          Container(
            decoration: BoxDecoration(color: Colors.orangeAccent),
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            child: Text(
              "* Loading a network image takes time to download the image data.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
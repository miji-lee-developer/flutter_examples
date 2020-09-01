import 'dart:math';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
      home: LoadFadeInImageFromNetwork(title: 'Load Image From Network'),
    );
  }
}

LoadFadeInImageFromNetworkState pageState;

class LoadFadeInImageFromNetwork extends StatefulWidget {
  LoadFadeInImageFromNetwork({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoadFadeInImageFromNetworkState createState() {
    pageState = LoadFadeInImageFromNetworkState();
    return pageState;
  }
}

class LoadFadeInImageFromNetworkState extends State<LoadFadeInImageFromNetwork> {
  String url = "https://picsum.photos/300?${Random().nextInt(100)}";

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 300,
            child: Stack(
              alignment: Alignment(0, 0),
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: url,
                  ),
                ),
              ],
            ),
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
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(top: 3, right: 15),
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.all(0),
              height: 40,
              width: 40,
              child: FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    getImage();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  getImage() {
    url = "https://picsum.photos/300?${Random().nextInt(100)}";
  }
}
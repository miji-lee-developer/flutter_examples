import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      home: LoadCachedNetworkImage(title: 'Load Image From Network'),
    );
  }
}

LoadCachedNetworkImageState pageState;

class LoadCachedNetworkImage extends StatefulWidget {
  LoadCachedNetworkImage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoadCachedNetworkImageState createState() {
    pageState = LoadCachedNetworkImageState();
    return pageState;
  }
}

class LoadCachedNetworkImageState extends State<LoadCachedNetworkImage> {
  String url = "https://picsum.photos/300";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 300,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: url,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          Text(url),
          Container(
            decoration: BoxDecoration(color: Colors.orangeAccent),
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            child: Text(
              "* Cached images are loaded quickly without re-downloading.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
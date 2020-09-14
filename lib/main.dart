import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

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
      home: HttpGetDemo(title: 'Http Get Request'),
    );
  }
}

HttpGetDemoState pageState;

class HttpGetDemo extends StatefulWidget {
  HttpGetDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HttpGetDemoState createState() {
    pageState = HttpGetDemoState();
    return pageState;
  }
}

class HttpGetDemoState extends State<HttpGetDemo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController teCon = TextEditingController(text: "https://jsonplaceholder.typicode.com/albums");
  FocusNode myFocusNode = FocusNode();
  String response = "";
  TextStyle ts = TextStyle(fontSize: 12);

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    teCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                customButton("albums", "https://jsonplaceholder.typicode.com/albums"),
                customButton("comments", "https://jsonplaceholder.typicode.com/comments"),
                customButton("Google", "https://google.com"),
                customButton("Flutter", "https://flutter.dev"),
                customButton("Facebook", "https://facebook.com"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("URL: ", style: ts),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        style: TextStyle(fontSize: 10),
                        decoration: InputDecoration(),
                        controller: teCon,
                        focusNode: myFocusNode,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text("GET", style: ts),
                      onPressed: () {
                        _getUrl(teCon.text.toString());
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: 55,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Text("launch", style: ts),
                      onPressed: () {
                        _launchUrl(teCon.text.toString());
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Center(
                        child: (response == null)
                            ? CircularProgressIndicator()
                            : SingleChildScrollView(
                              child: Text(response, style: TextStyle(fontSize: 13))
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  customButton(String text, String url) {
    return Container(
      width: 70,
      child: RaisedButton(
        padding: const EdgeInsets.all(0),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(text, style: ts),
        onPressed: () {
          teCon.text = url;
        },
      ),
    );
  }

  _getUrl(String url) async {
    setState(() {
      response = null;
    });
    var temp = await http.get(url);
    setState(() {
      response = temp.body;
    });
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      scaffoldKey.currentState
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("'$url' is invalid a URL"),
              backgroundColor: Colors.deepOrange,
              action: SnackBarAction(
                label: "Done",
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
    }
  }
}
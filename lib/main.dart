import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      home: OpenWebBrowser(title: 'Open Web Browser'),
    );
  }
}

OpenWebBrowserState pageState;

class OpenWebBrowser extends StatefulWidget {
  OpenWebBrowser({Key key, this.title}) : super(key: key);

  final String title;

  @override
  OpenWebBrowserState createState() {
    pageState = OpenWebBrowserState();
    return pageState;
  }
}

class OpenWebBrowserState extends State<OpenWebBrowser> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController teCon = TextEditingController(text: "http://google.com");

  FocusNode myFocusNode = FocusNode();

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customButton("Google", "https://google.com"),
            customButton("Flutter", "https://flutter.dev"),
            customButton("Facebook", "https://facebook.com"),
            Divider(color: Colors.grey, height: 50, indent: 50, endIndent: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("URL: "),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(),
                        controller: teCon,
                        focusNode: myFocusNode,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text("launch"),
                      onPressed: () {
                        _launchUrl(teCon.text.toString());
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: 65,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Text("clear"),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(myFocusNode);
                        teCon.text = "http://";
                      },
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
      width: 250,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(text),
        onPressed: () {
          teCon.text = url;
        },
      ),
    );
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
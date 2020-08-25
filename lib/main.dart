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
      home: ButtonWidget(title: 'Button Widget Demo'),
    );
  }
}

ButtonWidgetState pageState;

class ButtonWidget extends StatefulWidget {
  ButtonWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ButtonWidgetState createState() {
    pageState = ButtonWidgetState();
    return pageState;
  }
}

class ButtonWidgetState extends State<ButtonWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            Center(
              child: FlatButton(
                child: Text("FlatButton"),
                onPressed: () {
                  showSnackBar("FlatButton");
                },
              ),
            ),
            Center(
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("FlatButton with Color & Shape"),
                onPressed: () {
                  showSnackBar("FlatButton with Color & Shape");
                },
              ),
            ),
            Center(
              child: OutlineButton(
                color: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text("OutlineButton with Shape"),
                onPressed: () {
                  showSnackBar("OutlineButton with Shape");
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("RaisedButton"),
                onPressed: () {
                  showSnackBar("RaisedButton");
                },
              ),
            ),
            Center(
              child: RaisedButton(
                color: Colors.orange,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("RaisedButton with Color"),
                onPressed: () {
                  showSnackBar("RaisedButton with Color");
                },
              ),
            ),
            Center(
              child: IconButton(
                color: Colors.redAccent,
                icon: Icon(Icons.directions_bus),
                onPressed: () {
                  showSnackBar("IconButton");
                },
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(0),
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    showSnackBar("FloatingActionButton");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSnackBar(String message) {
    scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.blue,
            action: SnackBarAction(
              label: "Done",
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
  }
}
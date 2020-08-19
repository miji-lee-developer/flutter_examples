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
      home: AlertDialogDemo(title: 'AlertDialog Demo'),
    );
  }
}

AlertDialogDemoState pageState;

class AlertDialogDemo extends StatefulWidget {
  AlertDialogDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AlertDialogDemoState createState() {
    pageState = AlertDialogDemoState();
    return pageState;
  }
}

class AlertDialogDemoState extends State<AlertDialogDemo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: RaisedButton(
          child: Text("Show AlertDialog"),
          onPressed: () {
            showAlertDialog(context);
          },
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("AlertDialog Demo"),
          content: Text("Select button you want"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        );
      },
    );

    scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text("Result: $result"),
        backgroundColor: (result == "OK") ? Colors.orange : Colors.blueAccent,
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
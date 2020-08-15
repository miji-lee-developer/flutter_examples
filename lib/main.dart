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
      home: SnackBarWidget(title: 'SnackBar Demo'),
    );
  }
}

SnackBarWidgetState pageState;

class SnackBarWidget extends StatefulWidget {
  SnackBarWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SnackBarWidgetState createState() {
    pageState = SnackBarWidgetState();
    return pageState;
  }
}

class SnackBarWidgetState extends State<SnackBarWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("Show Snackbar - call directly"),
            onPressed: (){
              scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Did you call me?"),
                  backgroundColor: Colors.orange,
                  action: SnackBarAction(
                    label: "Done",
                    textColor: Colors.white,
                    onPressed: (){},
                  ),
                ),
              );
            },
          ),
          RaisedButton(
            child: Text("Show Snackbar - with method"),
            onPressed: (){
              showSnackbarWithKey();
            },
          ),
          RaisedButton(
            child: Text("Show Snackbar - with other class"),
            onPressed: () {
              SnackBarManager.showSnackBar(scaffoldKey, "Hello");
            },
          ),
        ],
      ),
    );
  }

  showSnackbarWithKey() {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Did you call me?"),
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

class SnackBarManager {
  static void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message + ", Did you call me?"),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
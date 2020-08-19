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
      home: WillPopScopeDemo(title: 'WillPopScope Demo'),
    );
  }
}

WillPopScopeDemoState pageState;

class WillPopScopeDemo extends StatefulWidget {
  WillPopScopeDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WillPopScopeDemoState createState() {
    pageState = WillPopScopeDemoState();
    return pageState;
  }
}

class WillPopScopeDemoState extends State<WillPopScopeDemo> {
  DateTime currentBackPressTime;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = onPressBackButton();
        return await Future.value(result);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Text("Tap back button to leave this page"),
        ),
      ),
    );
  }

  bool onPressBackButton() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("Tap back again to leave"),
        )
      );
      return false;
    }
    return true;
  }
}
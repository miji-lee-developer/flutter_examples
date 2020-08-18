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
      home: NaviGetData(title: 'First Screen'),
    );
  }
}

NaviGetDataState pageState;

class NaviGetData extends StatefulWidget {
  NaviGetData({Key key, this.title}) : super(key: key);

  final String title;

  @override
  NaviGetDataState createState() {
    pageState = NaviGetDataState();
    return pageState;
  }
}

class NaviGetDataState extends State<NaviGetData> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: RaisedButton(
          child: Text("Launch Screen"),
          onPressed: () {
            receiveData(context);
          },
        ),
      ),
    );
  }

  receiveData(BuildContext context) async {
    String result = await Navigator.push(context, MaterialPageRoute(builder: (context) => NaviReturnData()));
    scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("Received Data: $result")));
  }
}

class NaviReturnData extends StatelessWidget {
  List<String> fruits = ["Apples", "Oranges", "Bananas"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${fruits[index]}"),
              onTap: () {
                Navigator.pop(context, fruits[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
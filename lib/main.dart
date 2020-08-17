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
      home: NaviSendData(title: 'First Screen'),
    );
  }
}

NaviSendDataState pageState;

class NaviSendData extends StatefulWidget {
  NaviSendData({Key key, this.title}) : super(key: key);

  final String title;

  @override
  NaviSendDataState createState() {
    pageState = NaviSendDataState();
    return pageState;
  }
}

class NaviSendDataState extends State<NaviSendData> {
  List<String> fruits = ['Apples', 'Oranges', 'Bananas'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${fruits[index]}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NaviReceiveData(fruits[index]))
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NaviReceiveData extends StatelessWidget {
  final String fruit;

  NaviReceiveData(this.fruit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Received Data: "),
            Text(
              fruit,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
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
      home: ListViewBasic(title: 'ListView Demo - Basic'),
    );
  }
}

ListViewBasicState pageState;

class ListViewBasic extends StatefulWidget {
  ListViewBasic({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ListViewBasicState createState() {
    pageState = ListViewBasicState();
    return pageState;
  }
}

class ListViewBasicState extends State<ListViewBasic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          Text("First Item - Text"),
          Container(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text("Second Item - Text in Container"),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("3rd Item"),
            subtitle: Text("ListTile"),
          ),
          RaisedButton(
            child: Text("4th Item - RaisedButton"),
          ),
          Card(
            child: Text("5th Item - Text in Card"),
          ),
          Card(
            child: Text("5th Item - Text in Card"),
          ),
          Text("Various kinds of widgets can be registered as items of ListView Widget"),
        ],
      ),
    );
  }
}
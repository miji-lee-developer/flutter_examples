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
      home: MyHomePage(title: 'Basic Row Widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
          boxWidget(),
          boxWidget(),
          boxWidget(),
        ],
      ),
    );
  }

  boxWidget(){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.blue[700],
        border: Border.all(color: Colors.indigo, width: 0.5)
      ),
      child: Center(
        child: Text("Box", style: TextStyle(fontSize: 12, color: Colors.white))
      ),
    );
  }
}

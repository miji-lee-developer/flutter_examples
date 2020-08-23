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
      home: GridViewDemo(title: 'GridView Demo'),
    );
  }
}

GridViewDemoState pageState;

class GridViewDemo extends StatefulWidget {
  GridViewDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GridViewDemoState createState() {
    pageState = GridViewDemoState();
    return pageState;
  }
}

class GridViewDemoState extends State<GridViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GridView.count(
        crossAxisCount: 4,
        children: List.generate(1000, (index) {
          return boxItem(index);
        }),
      ),
    );
  }

  boxItem(int index) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: (index % 3 == 0)
            ? Colors.red
            : (index % 3 == 1) ? Colors.blue : Colors.orange
      ),
      alignment: Alignment(0, 0),
      child: Text(
        "Item $index",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
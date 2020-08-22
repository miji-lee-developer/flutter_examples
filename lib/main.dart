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
      home: ListViewHorizontal(title: 'ListView - Horizontal'),
    );
  }
}

ListViewHorizontalState pageState;

class ListViewHorizontal extends StatefulWidget {
  ListViewHorizontal({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ListViewHorizontalState createState() {
    pageState = ListViewHorizontalState();
    return pageState;
  }
}

class ListViewHorizontalState extends State<ListViewHorizontal> {
  List<Container> items;

  ListViewHorizontalState() {
    items = List<Container>.generate(100, (index) {
      return boxItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          },
        ),
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
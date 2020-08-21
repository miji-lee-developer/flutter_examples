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
      home: ListViewWithBuilder(title: 'ListView with builder'),
    );
  }
}

ListViewWithBuilderState pageState;

class ListViewWithBuilder extends StatefulWidget {
  ListViewWithBuilder({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ListViewWithBuilderState createState() {
    pageState = ListViewWithBuilderState();
    return pageState;
  }
}

class ListViewWithBuilderState extends State<ListViewWithBuilder> {
  List<String> items;

  ListViewWithBuilderState() {
    items = List<String>.generate(100, (index) {
      return "Item - $index";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String item = items[index];
          return ListTile(
            title: Text(item),
          );
        }
      ),
    );
  }
}
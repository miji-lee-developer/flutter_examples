import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Swipe Delete")),
      body: Center(child: SwipeList()),
    );
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CircleWidgets();
  }
}

class CircleWidgets extends State<SwipeList> {
  List items = getDummyList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(items[index]),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                // child: Icon(Icons.delete, color: Colors.white),
                child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
            },
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(border: Border.all(width: 1.0)),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Text(
                    items[index],
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
}
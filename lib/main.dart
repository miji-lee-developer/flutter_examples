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
      home: ListViewWithDiffTypeItems(title: 'ListView with different types of items'),
    );
  }
}

abstract class ListsItem {}

class HeadingItem implements ListsItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListsItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}

ListViewWithDiffTypeItemsState pageState;

class ListViewWithDiffTypeItems extends StatefulWidget {
  ListViewWithDiffTypeItems({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ListViewWithDiffTypeItemsState createState() {
    pageState = ListViewWithDiffTypeItemsState();
    return pageState;
  }
}

class ListViewWithDiffTypeItemsState extends State<ListViewWithDiffTypeItems> {
  List<ListsItem> items;

  ListViewWithDiffTypeItemsState() {
    items = List<ListsItem>.generate(100, (index) {
      if (index % 5 == 0) {
        return HeadingItem("HeadingItem $index");
      }
      else {
        return MessageItem("Sender $index", "Message body $index");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (item is HeadingItem) {
            return ListTile(title: Text(item.heading, style: TextStyle(fontWeight: FontWeight.bold)));
          }
          else if (item is MessageItem) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListTile(
                title: Text(item.sender),
                subtitle: Text(item.body),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
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
      home: ListViewHandleItem2(title: 'ListView Handle Items2'),
    );
  }
}

ListViewHandleItem2State pageState;

class ListViewHandleItem2 extends StatefulWidget {
  ListViewHandleItem2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ListViewHandleItem2State createState() {
    pageState = ListViewHandleItem2State();
    return pageState;
  }
}

class ListViewHandleItem2State extends State<ListViewHandleItem2> {
  List<String> items = List<String>.generate(7, (index) {
    return "Item - $index";
  });

  TextEditingController insertCon = TextEditingController(
    text: "good",
  );
  TextEditingController changeCon = TextEditingController();

  int selectedIndex;

  @override
  void dispose() {
    insertCon.dispose();
    changeCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 70,
              alignment: Alignment(0, 0),
              color: Colors.orange,
              child: Text(
                "To remove an item, swipe the tile to the right or tap the trash icon.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return  Dismissible(
                  key: Key(item),
                  direction: DismissDirection.startToEnd,
                  child: InkWell(
                    child: ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      selectedIndex = index;
                      changeCon.text = items[index];
                    },
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 5,
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Text("Change Item: "),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: changeCon,
                      onSubmitted: (text) {
                        _changeItem();
                      },
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Change"),
                  onPressed: () {
                    _changeItem();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Text("Insert Item: "),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: insertCon,
                      onSubmitted: (text) {
                        setState(() {
                          if (insertCon.text != "") {
                            items.add(insertCon.text);
                          }
                        });
                        insertCon.clear();
                      },
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Insert"),
                  onPressed: () {
                    setState(() {
                      if (insertCon.text != "") {
                        items.add(insertCon.text);
                      }
                    });
                    insertCon.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _changeItem() {
    if (selectedIndex == null || changeCon.text.isEmpty) {
      return;
    }
    print("selectedIndex: $selectedIndex, changedText: ${changeCon.text}");
    setState(() {
      items[selectedIndex] = changeCon.text;
    });
    selectedIndex = null;
    changeCon.text = "";
  }
}
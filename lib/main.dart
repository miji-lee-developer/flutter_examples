import 'dart:async';
import 'dart:math';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:faker/faker.dart';

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
      home: RawSQLDemo(title: 'Raw SQL Demo'),
    );
  }
}

RawSQLDemoState pageState;

class RawSQLDemo extends StatefulWidget {
  RawSQLDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  RawSQLDemoState createState() {
    pageState = RawSQLDemoState();
    return pageState;
  }
}

class RawSQLDemoState extends State<RawSQLDemo> {
  double _width;  // width of screen

  String _dbPath = "";  // path of database
  String _tableName = ""; // table name

  List<SQLItem> items = List<SQLItem>();  // to generate ListView
  SQLItem currentItem;

  // TextEditingController
  TextEditingController teConName = TextEditingController();
  TextEditingController teConAge = TextEditingController();

  Faker faker = Faker();  // to generate List Items

  @override
  void initState() {
    super.initState();
    getDBInfo();
    selectAllItems();
  }

  void getDBInfo() async {
    await DBManager.prepareDBPath(callback: (String dbPath, String tableName) {
      setState(() {
        _dbPath = dbPath;
        _tableName = tableName;
      });
    });
  }

  void selectAllItems() async {
    var result = await DBManager.selectAllItem();
    if (result != null) {
      setState(() {
        items = result;
      });
    }
  }

  void insertItem(SQLItem item) async {
    await DBManager.insertItem(item);
    selectAllItems();
  }

  void insertManyItems() async {
    print('click insertManyItem button');
    await DBManager.insertMany();
    selectAllItems();
  }

  void deleteItem(int id) async {
    await DBManager.deleteItem(id);
    selectAllItems();
  }

  void updateItem(SQLItem item) async {
    print(item.toString());
    await DBManager.updateItem(item);
    selectAllItems();
  }

  void deleteDB() async {
    await DBManager.deleteDB();
    selectAllItems();
  }

  void onTapItem(SQLItem item) {
    setState(() {
      currentItem = item;
    });
    teConName.text = currentItem.name;
    teConAge.text = currentItem.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false, // for fixing popup keyboard error
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          dbInfoArea(),
          buttonArea(),
          itemHeaderArea(),
          itemListArea(context),
          updateItemArea(),
        ],
      ),
    );
  }

  dbInfoArea() {
    customRow(String head, String body) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: _width * 0.2,
              child: Text(
                head,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  body,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[400], width: 1)),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: Colors.grey[200],
            alignment: Alignment(-1, 0),
            child: Text(
              "DB Info",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[400],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: <Widget>[
                customRow("DB Path", _dbPath),
                customRow("Table Name", _tableName),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buttonArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          customButton("Insert", () {
            insertItem(SQLItem(faker.person.name(), Random().nextInt(100)));
          }),
          Padding(padding: const EdgeInsets.all(3)),
          customButton("Insert Many", () {
            insertManyItems();
          }),
          Padding(padding: const EdgeInsets.all(3)),
          customButton("Delete DB", () {
            deleteDB();
          }),
        ],
      ),
    );
  }

  itemHeaderArea() {
    TextStyle ts = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
      // color: Colors.grey[200],
      height: 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(height: 1, color: Colors.grey[300]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _width * 0.1,
                alignment: Alignment(0, 0),
                child: Text("ID", style: ts),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment(0, 0),
                  child: Text("Name", style: ts),
                ),
              ),
              Container(
                width: _width * 0.2,
                alignment: Alignment(0, 0),
                child: Text("Age", style: ts),
              ),
              Container(
                width: _width * 0.15,
                alignment: Alignment(0, 0),
                child: Text("Query", style: ts),
              ),
            ],
          ),
          Container(height: 1.5, color: Colors.grey[300]),
        ],
      ),
    );
  }

  itemListArea(BuildContext context) {
    TextStyle ts = TextStyle(fontSize: 13);
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final SQLItem item = items[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    onTapItem(item);
                  },
                  child: Container(
                    height: 30,
                    color: (index % 2 == 0) ? Colors.grey[100] : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: _width * 0.1,
                          alignment: Alignment(0, 0),
                          child: Text(item.id.toString(), style: ts),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment(0, 0),
                            child: Text(item.name, style: ts),
                          ),
                        ),
                        Container(
                          width: _width * 0.2,
                          alignment: Alignment(0, 0),
                          child: Text(item.age.toString(), style: ts),
                        ),
                        Container(
                          width: _width * 0.15,
                          alignment: Alignment(0, 0),
                          child: InkWell(
                            child: Icon(Icons.delete, color: Colors.blueGrey),
                            onTap: () {
                              deleteItem(item.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 1, color: Colors.grey[300]),
              ],
            ),
          );
        },
      ),
    );
  }

  updateItemArea() {
    TextStyle ts = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 5),
            alignment: Alignment(-1, 0),
            child: Text(
              "* Update List Item (Select an item to update from the list)",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          itemHeaderArea(),
          Container(
            // color: Colors.grey[200],
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                Container(
                  width: _width * 0.1,
                  alignment: Alignment(0, 0),
                  child: (currentItem != null)
                    ? Text(currentItem.id.toString(), style: ts)
                    : null,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: teConName,
                      textAlign: TextAlign.center,
                      style: ts,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _width * 0.2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: teConAge,
                    textAlign: TextAlign.center,
                    style: ts,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _width * 0.15,
                  child: InkWell(
                    child: Icon(Icons.sync),
                    onTap: () {
                      if (currentItem == null) return;
                      SQLItem item = SQLItem(teConName.text, int.parse(teConAge.text.toString()));
                      item.id = currentItem.id;
                      updateItem(item);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  customButton(String text, Null Function() onPressed) {
    return SizedBox(
      height: 20,
      width: _width * 0.312,
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        color: Colors.blue,
        disabledColor: Colors.grey,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: TextStyle(fontSize: 13),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class SQLItem {
  int id;
  String name;
  int age;

  SQLItem(this.name, this.age);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;
    return map;
  }

  SQLItem.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    age = map["age"];
  }
}

class DBManager {
  static String dbPath;
  static final String dbName = "demo.db";
  static final String tableName = "test";

  static Database _db;

  static Future<void> prepareDBPath({void Function(String dbPath, String dbFile) callback}) async {
    String path = await getDatabasesPath();
    dbPath = join(path, dbName);
    if (callback != null) callback(dbPath, tableName);
  }

  static Future<Database> _openDB() async {
    if (_db == null) _db = await _initDB();
    return _db;
  }

  static _initDB() async {
    await prepareDBPath();
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
  }

  static void deleteDB() async {
    var database = await _openDB();
    await deleteDatabase(dbPath);
    await database.close();
    _db = null;
  }

  static Future<void> insertItem(SQLItem item) async {
    var database = await _openDB();
    return await database.rawInsert('INSERT INTO $tableName(name, age) VALUES ("${item.name}", ${item.age})');
  }

  static void insertMany() async {
    var db = await _openDB();
    db.transaction((txn) async {
      for(int i = 0; i < 5; i++) {
        print("${faker.person.name()}");
        await txn.rawInsert('INSERT INTO $tableName(name, age) VALUES ("${faker.person.name()}", ${Random().nextInt(100)})');
      }
    });
  }

  static Future<int> deleteItem(int id) async {
    var database = await _openDB();
    return await database.rawDelete('DELETE FROM $tableName WHERE id = $id');
  }

  static Future<int> updateItem(SQLItem item) async {
    var database = await _openDB();
    return await database.rawUpdate(
      'UPDATE $tableName SET name = ?, age = ? WHERE id = ?',
      [item.name, item.age, item.id]
    );
  }

  static Future<List<SQLItem>> selectAllItem() async {
    var database = await _openDB();
    List<Map> rawList = await database.rawQuery('SELECT * FROM $tableName ORDER BY id DESC');

    List<SQLItem> itemList = List<SQLItem>();
    for (int i = 0; i < rawList.length; i++) {
      SQLItem item = SQLItem.fromMap(rawList[i]);
      itemList.add(item);
    }
    return itemList;
  }
}
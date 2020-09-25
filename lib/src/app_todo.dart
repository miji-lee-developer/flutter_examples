import 'package:flutter/material.dart';
import 'app_todo_add_item.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  Widget _buildTodoList() {
    return new ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  _addTodoItem(String item) {
    setState(() {
      _todoItems.add(item);
    });
  }

  _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Do you want to complete "${_todoItems[index]}"?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _navigatorAddItemScreen() async {
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return AddItemScreen();
      },
    ));

    if(results != null && results.containsKey("item")) {
      _addTodoItem(results["item"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _navigatorAddItemScreen(),
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
    );
  }
}
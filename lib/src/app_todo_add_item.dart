import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adding to do')),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            autofocus: true,
            onSubmitted: (val) {
              Navigator.of(context).pop({'item': val});
            },
          ),
        ),
      ),
    );
  }
}
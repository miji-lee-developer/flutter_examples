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
      home: ContainerWidget(title: 'Container Widget Demo'),
    );
  }
}

ContainerWidgetState pageState;

class ContainerWidget extends StatefulWidget {
  ContainerWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ContainerWidgetState createState(){
    pageState = ContainerWidgetState();
    return pageState;
  }
}

class ContainerWidgetState extends State<ContainerWidget>{
  double _height = 100;
  double _width = 100;
  double _padding = 1;
  double _margin = 1;
  double _border = 1;
  Color _bgColor = Colors.red;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: Center(
              child: Container(
                height: _height,
                width: _width,
                padding: EdgeInsets.all(_padding),
                margin: EdgeInsets.all(_margin),
                decoration: BoxDecoration(
                  color: _bgColor, border: Border.all(width: _border)
                ),
                child: Text(
                  "This is a Container",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Height"),
              Slider(
                value: _height,
                min: 50,
                max: 300,
                onChanged: (newValue){
                  setState((){
                    _height = newValue;
                  });
                },
              ),
              Text(_height.toInt().toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Width"),
              Slider(
                value: _width,
                min: 50,
                max: 300,
                onChanged: (newValue) {
                  setState((){
                    _width = newValue;
                  });
                },
              ),
              Text(_width.toInt().toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Padding"),
              Slider(
                value: _padding,
                min: 0,
                max: 100,
                onChanged: (newValue) {
                  setState((){
                    _padding = newValue;
                  });
                },
              ),
              Text(_padding.toInt().toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Margin"),
              Slider(
                value: _margin,
                min: 0,
                max: 50,
                onChanged: (newValue) {
                  setState((){
                    _margin = newValue;
                  });
                },
              ),
              Text(_margin.toInt().toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Border"),
              Slider(
                value: _border,
                min: 0,
                max: 50,
                onChanged: (newValue) {
                  setState((){
                    _border = newValue;
                  });
                },
              ),
              Text(_border.toInt().toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Color"),
              RaisedButton(
                child: Text("Red"),
                onPressed: (){
                  setState((){
                    _bgColor = Colors.red;
                  });
                },
              ),
              RaisedButton(
                child: Text("Blue"),
                onPressed:(){
                  setState((){
                    _bgColor = Colors.blue;
                  });
                },
              ),
              RaisedButton(
                child: Text("Orange"),
                onPressed: (){
                  setState((){
                    _bgColor = Colors.orange;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
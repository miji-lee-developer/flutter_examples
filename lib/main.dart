import 'package:flutter/material.dart';
import 'package:app_review/app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';

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
      home: ReviewAppDemo(title: 'Request App Review Demo'),
    );
  }
}

ReviewAppDemoState pageState;

class ReviewAppDemo extends StatefulWidget {
  ReviewAppDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ReviewAppDemoState createState() {
    pageState = ReviewAppDemoState();
    return pageState;
  }
}

class ReviewAppDemoState extends State<ReviewAppDemo> {
  String appID = "";
  String output = "";

  @override
  initState() {
    super.initState();

    AppReview.getAppID.then((onValue) {
      setState(() {
        appID = onValue;
      });
      print("App ID: " + appID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("App ID"),
              subtitle: Text(appID),
            ),
          ),
          Expanded(
            child: Center(
              child: RaisedButton.icon(
                color: Colors.blueAccent,
                textColor: Colors.white,
                icon: Icon(Icons.star),
                label: Text("Review App"),
                onPressed: () {
                  rateApp();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void rateApp() {
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) {
        return RatingDialog(
          icon: const FlutterLogo(size: 100, colors: Colors.blue),
          // set your own image/icon widget
          title: "The Rating Dialog",
          description: "Tap a star to set your rating. Add more description here if you want.",
          submitButton: "SUBMIT",
          alternativeButton: "Contact us instead?",
          // optional
          positiveComment: "We are so happy to hear :)",
          // optional
          negativeComment: "We're sad to hear :(",
          // optional
          accentColor: Colors.blue,
          // optional
          onSubmitPressed: (int rating) {
            print("onSubmitPressed: rating = $rating");
            AppReview.writeReview;
          },
          onAlternativePressed: () {
            print("onAlternativePressed: do something");
          },
        );
      },
    );
  }
}
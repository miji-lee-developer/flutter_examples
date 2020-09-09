import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:package_info/package_info.dart';

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
      home: ShareAppDemo(title: 'Share App Demo'),
    );
  }
}

ShareAppDemoState pageState;

class ShareAppDemo extends StatefulWidget {
  ShareAppDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ShareAppDemoState createState() {
    pageState = ShareAppDemoState();
    return pageState;
  }
}

class ShareAppDemoState extends State<ShareAppDemo> {
  String appName;
  String appID;

  @override
  void initState() {
    super.initState();
    prepareInfo();
  }

  void prepareInfo() async {
    PackageInfo pInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = pInfo.appName;
      appID = pInfo.packageName;
    });
  }

  Future<void> shareApp() async {
    await FlutterShare.share(
      chooserTitle: "Share $appName",
      title: appName,
      text: "Introducing the Flutter Code Examples app.",
      linkUrl: 'https://play.google.com/store/apps/details?id=$appID',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("App Name"),
              subtitle: Text(appName),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Package Name (AppID)"),
              subtitle: Text(appID),
            ),
          ),
          Expanded(
            child: Center(
              child: RaisedButton.icon(
                color: Colors.blueAccent,
                textColor: Colors.white,
                icon: Icon(Icons.share),
                label: Text("Share App"),
                onPressed: () {
                  shareApp();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
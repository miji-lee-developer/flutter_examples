import 'package:flutter/material.dart';
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
      home: AppInfoDemo(title: 'App Information'),
    );
  }
}

AppInfoDemoState pageState;

class AppInfoDemo extends StatefulWidget {
  AppInfoDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AppInfoDemoState createState() {
    pageState = AppInfoDemoState();
    return pageState;
  }
}

class AppInfoDemoState extends State<AppInfoDemo> {
  String appName = "";
  String appID = "";
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  void getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      appID = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
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
          Card(
            child: ListTile(
              title: Text("Version"),
              subtitle: Text(version),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Build Number"),
              subtitle: Text(buildNumber),
            ),
          ),
        ],
      ),
    );
  }
}
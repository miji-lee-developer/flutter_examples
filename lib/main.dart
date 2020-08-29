import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

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
      home: AdmobFlutterPluginDemo(title: 'Admob Flutter Plugin Demo'),
    );
  }
}

AdmobFlutterPluginDemoState pageState;

class AdmobFlutterPluginDemo extends StatefulWidget {
  AdmobFlutterPluginDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AdmobFlutterPluginDemoState createState() {
    pageState = AdmobFlutterPluginDemoState();
    return pageState;
  }
}

class AdmobFlutterPluginDemoState extends State<AdmobFlutterPluginDemo> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;

  @override
  Widget build(BuildContext context) {
    /** Admob Plugin **/
    Admob admob = AdmobManager.initAdmob();

    return WillPopScope(
      onWillPop: () async {
        await _defaultWillPop();
        return await Future.value(true);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: _appBar(),
        body: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  InkWell(
                    child: Text(
                      "BANNER",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      setState(() {
                        bannerSize = AdmobBannerSize.BANNER;
                      });
                    },
                  ),
                  InkWell(
                    child: Text(
                      "LARGE_BANNER",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      setState(() {
                        bannerSize = AdmobBannerSize.LARGE_BANNER;
                      });
                    },
                  ),
                  InkWell(
                    child: Text(
                      "MEDIUM_RECTANGLE",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      setState(() {
                        bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  if (index != 0 && index % 5 == 0) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: AdmobBanner(
                            adUnitId: AdmobManager._isTest
                                ? AdmobManager.test_banner_id
                                : AdmobManager.banner_id,
                            adSize: bannerSize,
                          ),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment(0, 0),
                          color: Colors.cyan,
                          child: Text(
                            "List Items - $index",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.all(5),
                      alignment: Alignment(0, 0),
                      color: Colors.cyan,
                      child: Text(
                        "List Items - $index",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: (admob != null)
          ? Container(
              color: Colors.blueGrey,
              child: AdmobManager.bottomBanner,
            )
          : null,
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  _defaultWillPop() async {
    var result = await showDialog(
      context: scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Container(child: Text("Do you want to leave?"),),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(color: Colors.white),
            child: AdmobManager.finishBanner,
          ),
          actions: <Widget> [
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );

    return result;
  }
}

class AdmobManager {
  static bool _isTest = true;

  /** Test IDs **/
  static String test_app_id = "ca-app-pub-3940256099942544~3347511713";
  static String test_banner_id = "ca-app-pub-3940256099942544/6300978111";

  /** You real IDs **/
  static String app_id = "ca-app-pub-3940256099942544~3347511713";
  static String banner_id = "ca-app-pub-3940256099942544/6300978111";

  static Admob initAdmob() {
    print("initAdmob");
    return Admob.initialize(_isTest ? test_app_id : app_id);
  }

  static AdmobBanner bottomBanner = AdmobBanner(
    adUnitId: _isTest ? test_banner_id : banner_id,
    adSize: AdmobBannerSize.BANNER,
  );

  static AdmobBanner finishBanner = AdmobBanner(
    adUnitId: _isTest ? test_banner_id : banner_id,
    adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
  );
}
import 'package:flutter/material.dart';

import 'package:flutter_app_examples/youtube_clone_app/src/models/UserData.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/commons/colors.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/tabs/youtubeScreen.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/tabs/NearByScreen.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/tabs/ChatScreen.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/utils/fb_api_provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  var _tabIndex = 0;

  @override
  Widget build(BuildContext context) {

  }
}
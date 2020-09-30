import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/models/ChatData.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/models/UserData.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/utils/fb_api_provider.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/widgets/Bubble.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
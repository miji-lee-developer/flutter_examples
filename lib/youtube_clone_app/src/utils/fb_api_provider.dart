import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/models/ChatData.dart';
import 'package:flutter_app_examples/youtube_clone_app/src/models/UserData.dart';

class FbApiProvider {
  static final FbApiProvider _instance = FbApiProvider.internal();

  factory FbApiProvider() => _instance;

  FbApiProvider.internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String fireStoreCollectionName = "room";

  Future<UserData> handleSignIn() async {
    GoogleSignInAccount signInAccount = _googleSignIn.currentUser;

    if (signInAccount == null)
      signInAccount = await _googleSignIn.signInSilently();
    if (signInAccount == null)
      await _googleSignIn.signIn();

    UserData userData = UserData();
    String currentUserEmail = _googleSignIn.currentUser.email;
    String photoUrl = _googleSignIn.currentUser.photoUrl;
    String displayName = _googleSignIn.currentUser.displayName;

    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication credentials = await _googleSignIn.currentUser.authentication;
      FirebaseUser firebaseUser = await _auth.signInWithGoogle(
          idToken: credentials.idToken,
          accessToken: credentials.accessToken
      );

      currentUserEmail = firebaseUser.email;
      photoUrl = firebaseUser.photoUrl;
      displayName = firebaseUser.displayName;
    }

    userData.email = currentUserEmail;
    userData.photoUrl = photoUrl;
    userData.displayName = displayName;

    return userData;
  }

  saveChat(ChatData chatData) {
    Firestore.instance.collection(fireStoreCollectionName)
        .document()
        .setData(chatData.toMap());
  }

  Future<void> singOutProc() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
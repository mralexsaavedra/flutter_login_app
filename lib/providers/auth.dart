import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:flutter_login_app/global/constants.dart' as Constants;

abstract class AuthImpl {
  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> signUp(String email, String password);
  Future<FirebaseUser> googleSignIn();
  Future<FirebaseUser> twitterSignIn();
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth implements AuthImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: Constants.kTwitterApiKey,
    consumerSecret: Constants.kTwitterApiSecret,
  );

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _firebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return user;
  }

  Future<FirebaseUser> twitterSignIn() async {
    final TwitterLoginResult twitterLoginResult = await twitterLogin.authorize();
    final TwitterSession currentUserTwitterSession = twitterLoginResult.session;

    FirebaseUser user = await _firebaseAuth.signInWithTwitter(
        authToken: currentUserTwitterSession?.token ?? '',
        authTokenSecret: currentUserTwitterSession?.secret ?? ''
    );
    return user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
}
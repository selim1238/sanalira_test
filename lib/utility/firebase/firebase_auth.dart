import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseLoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;

  FirebaseLoginProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future register({String? email, String? password}) async {}

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

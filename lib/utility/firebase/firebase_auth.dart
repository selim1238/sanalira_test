import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseLoginProvider extends ChangeNotifier {
  var _usersCollection = FirebaseFirestore.instance.collection("Users");
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

  Future registerWithEmail({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future firestoreUserCreation(
      {String? email,
      String? name,
      String? surname,
      String? phoneNumber,
      String? countryCode,
      String? userId,
      String? creationDate}) async {
    try {
      await _usersCollection.doc(userId).set({
        "userId": userId,
        "creationDate": creationDate,
        "name": name,
        "surname": surname,
        "email": email,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
      });
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}

void logout() async {
  FirebaseAuth.instance.signOut();
}

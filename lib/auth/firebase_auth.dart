import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

signup(
  String email,
  String password,
) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "barry.allen@example.com", password: "SuperSecretPassword!");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      if (kDebugMode) {
        print('The password provided is too weak.');
      }
    } else if (e.code == 'email-already-in-use') {
      if (kDebugMode) {
        print('The account already exists for that email.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

login(String em, String pw) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: em, password: pw);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      if (kDebugMode) {
        print('No user found for that email.');
      }
    } else if (e.code == 'wrong-password') {
      if (kDebugMode) {
        print('Wrong password provided for that user.');
      }
    }
  }
}

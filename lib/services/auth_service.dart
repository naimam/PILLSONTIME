import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/config.dart';
import 'package:project/models/user.dart';

class AuthService {
  static final firebase.FirebaseAuth _firebaseAuth =
      firebase.FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Configurations().googleSignInWebClientId,
  );

  static Future<String> signUpWithEmailPassword(
      User user, String password) async {
    firebase.User firebaseUser;

    try {
      // Authenticate with Firebase
      final creds = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      firebaseUser = creds.user!;
      await Database.addNewUser(user, firebaseUser.uid);
    } on firebase.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }

    return 'Sign up successful';
  }

  static Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on firebase.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password.';
      }
      return e.code;
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

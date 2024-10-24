

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController{

  final FirebaseAuth auth = FirebaseAuth.instance;



  Future<bool> isEmailVerified() async {
    User? user = auth.currentUser;
    if (user != null) {
      await user.reload(); // Reload user data from Firebase
      return user.emailVerified;
    }
    return false;
  }




  static Future<User?> signInWithGoogle() async {
      final googleAccount = await GoogleSignIn().signIn();
      final googleAuth = await googleAccount?.authentication;


      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,);

      return userCredential.user;
  }
}
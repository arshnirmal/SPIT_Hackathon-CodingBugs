// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spit_hackathon/frontend/shared/toasts.dart';

class AuthenticationRepository {
  static AuthenticationRepository get instance => AuthenticationRepository();

  final _auth = FirebaseAuth.instance;
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Container(),
        ),
      );
    }

    return firebaseApp;
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        FlutterToast.showToast(
          'The password provided is too weak.',
          context,
        );
      } else if (e.code == 'email-already-in-use') {
        FlutterToast.showToast(
          'The account already exists for that email.',
          context,
        );
      }
    } catch (e) {
      FlutterToast.showToast(e.toString(), context);
    }
    return null;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          FlutterToast.showToast(
            'The account already exists with a different credential.',
            context,
          );
        } else if (e.code == 'invalid-credential') {
          FlutterToast.showToast(
            'Error occurred while accessing credentials. Try again.',
            context,
          );
        }
      } catch (e) {
        FlutterToast.showToast(e.toString(), context);
      }
    }

    return user;
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BaseAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> createAccountWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.signOut();
    }

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  Future<FirebaseUser> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }
}

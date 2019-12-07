import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<String> signInWithGoogle();

  Future<String> signInWithFacebook();

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
//  GoogleSignInAccount googleAccount;

//  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)).user;

    var isEmailVerified = user.isEmailVerified;

    print("Is Email Verified $isEmailVerified");


    user.sendEmailVerification();
    
    _firebaseAuth.sendPasswordResetEmail(email: null);

    return user.uid;
  }



//  Future<String> signInWithGoogle() async {
//    if (googleAccount == null) {
//      // Start the sign-in process:
//      googleAccount = await googleSignIn.signIn();
//    }
//    final GoogleSignInAuthentication _auth = await googleAccount.authentication;
//    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
//        idToken: _auth.idToken, accessToken: _auth.accessToken);
//    return (await _firebaseAuth.signInWithCredential(_authCredential)).uid;
//  }


  @override
  Future<String> signInWithGoogle() async {
    print('Inside sign in implementation');
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication _auth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _auth.accessToken,
      idToken: _auth.idToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }



  Future<GoogleSignInAccount> getSignedInAccount(GoogleSignIn googleSignIn) async {
    GoogleSignInAccount account = googleSignIn.currentUser;
    if (account == null) {
      account = await googleSignIn.signInSilently();
    }
    return account;
  }

  Future<String> signInWithFacebook() async {
//    final result = await _facebookLogin.logInWithReadPermissions(['email']);
//
//    final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
//
//    return (await _firebaseAuth.signInWithCredential(credential)).uid;
    return "";
  }



  Future<String> signUp(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password)).user;
    var isVerifiedFlag = user.isEmailVerified;
    print("Email Verified $isVerifiedFlag");
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}

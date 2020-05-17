import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/http_exception.dart';

import '../models/user.dart';

abstract class Auth {
  Future<void> currentUser();
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class AuthProvider extends ChangeNotifier implements Auth {
  final _firebaseAuthService = FirebaseAuth.instance;
  final _firestoreService = Firestore.instance;
  User _user;

  User get user {
    return _user;
  }

  Future<void> currentUser() async {
    final user = await _firebaseAuthService.currentUser();
    if (user == null) return;
    _user = User(
      uid: user.uid,
      fullName: user.displayName,
      photoUrl: user.photoUrl,
      email: user.email,
    );
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _firebaseAuthService
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = authResult.user;

      final document =
          await _firestoreService.collection('users').document(user.uid).get();
      if (!document.exists) {
        await Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData({
          'nickname': user.displayName,
          'photoUrl': user.photoUrl,
          'id': user.uid
        });
      }
      _user = User(
        uid: user.uid,
        fullName: user.displayName,
        photoUrl: user.photoUrl,
        email: user.email,
      );
      notifyListeners();
    } on PlatformException catch (error) {
      String errorMessage;
      if (error.code == 'ERROR_WEAK_PASSWORD') {
        errorMessage = 'Enter a strong Password.';
      } else if (error.code == 'ERROR_INVALID_EMAIL') {
        errorMessage = 'Invalid email.';
      } else if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        errorMessage = 'Email already registered.';
      } else {
        errorMessage = error.message;
      }
      throw HttpException(errorMessage);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await _firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);

      final user = authResult.user;
      _user = User(
        uid: user.uid,
        fullName: user.displayName,
        photoUrl: user.photoUrl,
        email: user.email,
      );
      notifyListeners();
    } on PlatformException catch (error) {
      String errorMessage;
      if (error.code == 'ERROR_INVALID_EMAIL') {
        errorMessage = 'Invalid email provided !';
      } else if (error.code == 'ERROR_WRONG_PASSWORD') {
        errorMessage = 'Email or Password wrong !!';
      } else if (error.code == 'ERROR_USER_NOT_FOUND') {
        errorMessage = 'Email not registered. Please signup first.';
      } else if (error.code == 'ERROR_USER_DISABLED') {
        errorMessage = 'This email is disabled. Please contact support.';
      } else if (error.code == 'ERROR_TOO_MANY_REQUESTS') {
        errorMessage =
            'Try again after sometime. Too many sign in were attempted.';
      } else if (error.code == 'ERROR_OPERATION_NOT_ALLOWED') {
        errorMessage =
            'Try different method for login. This method is disabled.';
      } else {
        errorMessage = error.message;
      }
      throw HttpException(errorMessage);
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
    _user = null;
    notifyListeners();
  }
}

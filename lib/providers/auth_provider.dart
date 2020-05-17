import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      print(document.exists);
      if (!document.exists) {
        print('object');
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
    } catch (error) {
      throw error;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
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
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
    _user = null;
    notifyListeners();
  }
}

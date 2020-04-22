import 'package:flutter/material.dart';

class User {
  final String uid;
  final String fullName;
  final String photoUrl;
  final String email;

  User({
    @required this.uid,
    @required this.fullName,
    @required this.photoUrl,
    @required this.email,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'fullName': fullName,
        'photoUrl': photoUrl,
        'email': email,
      };
}

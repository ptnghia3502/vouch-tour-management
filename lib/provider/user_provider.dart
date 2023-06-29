import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserCredential? _userCredential;

  UserCredential? get userCredential => _userCredential;

  void setUserCredential(UserCredential credential) {
    _userCredential = credential;
    notifyListeners();
  }
}

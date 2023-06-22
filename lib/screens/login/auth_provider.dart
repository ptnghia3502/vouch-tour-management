import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _jwt;

  String? get jwt => _jwt;

  set jwt(String? token) {
    _jwt = token;
    notifyListeners();
  }
}

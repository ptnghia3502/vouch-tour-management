import 'package:flutter/foundation.dart';

class JwtProvider with ChangeNotifier {
  String? _jwtToken;

  String? get jwtToken => _jwtToken;

  void setJwtToken(String? token) {
    _jwtToken = token;
    notifyListeners();
  }
}

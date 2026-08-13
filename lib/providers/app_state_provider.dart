import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _hasSeenWelcome = false;
  bool _isLoggedIn = false;

  bool get hasSeenWelcome => _hasSeenWelcome;
  bool get isLoggedIn => _isLoggedIn;

  void markWelcomeSeen() {
    _hasSeenWelcome = true;
    notifyListeners();
  }

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

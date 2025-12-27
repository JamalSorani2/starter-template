import 'package:flutter/material.dart';

class CountdownProvider with ChangeNotifier {
  int _remainingSeconds = 30;
  bool _isTimerRunning = false;

  int get remainingSeconds => _remainingSeconds;
  bool get isTimerRunning => _isTimerRunning;

  void startTimer() {
    if (!_isTimerRunning) {
      _isTimerRunning = true;
      _remainingSeconds = 30;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), _countdown);
    }
  }

  void _countdown() {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), _countdown);
    } else {
      _isTimerRunning = false;
      notifyListeners();
    }
  }

  void resetTimer() {
    _remainingSeconds = 30;
    notifyListeners();
  }
}

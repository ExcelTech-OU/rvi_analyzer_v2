import 'package:flutter/material.dart';

class ErrorModal extends ChangeNotifier {
  bool _isLevelOneErrorOccurred = false;
  bool _isLevelTwoErrorOccurred = false;
  bool _isLevelThreeErrorOccurred = false;

  void setLevelOneErrorOccurred(bool isLevelOneErrorOccurred) {
    _isLevelOneErrorOccurred = isLevelOneErrorOccurred;
    notifyListeners();
  }

  void setLevelTwoErrorOccurred(bool isLevelTwoErrorOccurred) {
    _isLevelTwoErrorOccurred = isLevelTwoErrorOccurred;
    notifyListeners();
  }

  void setLevelThreeErrorOccurred(bool isLevelThreeErrorOccurred) {
    _isLevelThreeErrorOccurred = isLevelThreeErrorOccurred;
    notifyListeners();
  }

  bool get isLevelOneErrorOccurred => _isLevelOneErrorOccurred;

  bool get isLevelTwoErrorOccurred => _isLevelTwoErrorOccurred;

  bool get isLevelThreeErrorOccurred => _isLevelThreeErrorOccurred;
}

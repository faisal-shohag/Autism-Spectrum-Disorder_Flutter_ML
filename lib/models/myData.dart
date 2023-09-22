import 'package:flutter/material.dart';

class MyData with ChangeNotifier {
  String _response = "Predicting...";
  String get response => _response;

  void updateGVal(String newVal) {
    _response = newVal;
    notifyListeners();
  }
}

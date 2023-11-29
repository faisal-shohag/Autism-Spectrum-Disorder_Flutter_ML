import 'package:flutter/material.dart';

class MyData with ChangeNotifier {
  String _response = "Predicting...";
  String get response => _response;

  void updateGVal(String newVal) {
    _response = newVal;
    notifyListeners();
  }
}

class CounterNotifier extends ChangeNotifier {
  int _counter = 1;
  int get counter => _counter;

  void updateCount(int newVal) {
    _counter = newVal;
    notifyListeners();
  }
}

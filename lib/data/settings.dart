import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  bool showApartment = false;
  bool showHouse = false;

  void changeShowApartment(bool newState) {
    showApartment = newState;
    notifyListeners();
  }

  void changeShowHouse(bool newState) {
    showHouse = newState;
    notifyListeners();
  }
}

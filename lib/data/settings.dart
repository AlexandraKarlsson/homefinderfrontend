import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  String search = '';
  bool showApartment = true;
  bool showHouse = true;
  bool showFavorites = false;

  void changeSearchString(String newSearch) {
    search = newSearch;
    notifyListeners();
  }

  void changeShowApartment(bool newState) {
    showApartment = newState;
    notifyListeners();
  }

  void changeShowHouse(bool newState) {
    showHouse = newState;
    notifyListeners();
  }

  void changeShowFavorites(bool newState) {
    showFavorites = newState;
    notifyListeners();
  }
}

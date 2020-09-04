import 'package:flutter/material.dart';

import 'favorite.dart';

class Favorites extends ChangeNotifier {
  Map<int,Favorite> favorites = Map<int,Favorite>();

  void add(List<dynamic> favoriteList) {
    favoriteList.forEach((favorite) {
      int homeId = favorite['homeid'];
      print('Favorites.add : homeid = $homeId');
      Favorite newFavorite = Favorite(homeId);
      favorites[homeId] = newFavorite;
    });
  }

  void put(int homeId) {
    Favorite favorite = Favorite(homeId);
    favorites[homeId] = favorite;
    notifyListeners();
  }

  void remove(int homeId) {
    favorites.remove(homeId);
    notifyListeners();
  }

  bool exists(int homeId) {
    return favorites.containsKey(homeId);
  }

  void clear() {
    favorites = Map<int,Favorite>();
    notifyListeners();
  }

}
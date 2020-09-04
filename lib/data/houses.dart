import 'package:flutter/material.dart';
import 'house.dart';

class Houses extends ChangeNotifier {
  List<House> houses = [];

  // Houses();
/*
  final int id;
  final String address;
  final String description;
  final double livingSpace;
  final double rooms;
  final int built;
  final int price;
  final int operationCost;
  final String image;
  final List<String> images;
   */
  void add(Map<String, dynamic> houseMap) {
    clear();
    houseMap['rows'].forEach((house) {
      int id = house['homeid'];
      String address = house['address'];
      String description = house['description'];
      int livingSpace = house['livingspace'];
      double rooms = house['rooms'].toDouble();
      int built = house['built'];
      int price = house['price'];
      int operationCost = house['operationcost'];
      String image = house['image'];
      List<String> images = house['images'];
      int brokerId = house['brokerid'];
      int saleId = house['saleid'];
      String cadastral = house['cadastral'];
      String structure = house['structure'];
      int plotSize = house['plotsize'];
      String ground = house['ground'];
      House newHouse = House(
        id,
        address,
        description,
        livingSpace,
        rooms,
        built,
        price,
        operationCost,
        image,
        images,
        brokerId,
        saleId,
        cadastral,
        structure,
        plotSize,
        ground,
      );
      houses.add(newHouse);
    });
  }

  void changePrice(int homeId, int newPrice) {
    houses.forEach((house) {
      if (house.id == homeId) {
        house.price = newPrice;
      }
    });
    notifyListeners();
  }

  void clear() {
    houses.clear();
  }
}

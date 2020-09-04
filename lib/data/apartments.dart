import 'package:flutter/material.dart';

import 'apartment.dart';

class Apartments extends ChangeNotifier {
  List<Apartment> apartments = [];

  // Apartments();
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
  void add(Map<String, dynamic> apartmentMap) {
    clear();
    apartmentMap['rows'].forEach((apartment) {
      int id = apartment['homeid'];
      String address = apartment['address'];
      String description = apartment['description'];
      int livingSpace = apartment['livingspace'];
      double rooms = apartment['rooms'].toDouble();
      int built = apartment['built'];
      int price = apartment['price'];
      int operationCost = apartment['operationcost'];
      String image = apartment['image'];
      List<String> images = apartment['images'];
      int brokerId = apartment['brokerid'];
      int saleId = apartment['saleid'];
      int apartmentNumber = apartment['apartmentnumber'];
      int charge = apartment['charge'];
      Apartment newApartment = Apartment(
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
          apartmentNumber,
          charge);
      apartments.add(newApartment);
    });
  }

  void changePrice(int homeId, int newPrice) {
    apartments.forEach((apartment) {
      if (apartment.id == homeId) {
        apartment.price = newPrice;
      }
    });
    notifyListeners();
  }

  void clear() {
    apartments.clear();
  }
}



import 'package:flutter/material.dart';

class Bid extends ChangeNotifier {
  final int saleId;
  final int userId;
  final int price;

  Bid(
    this.saleId,
    this.userId,
    this.price,
  );



}

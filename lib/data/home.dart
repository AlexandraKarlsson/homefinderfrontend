import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Home {
  final int id;
  final String address;
  final String description;
  final int livingSpace;
  final double rooms;
  final int built;
  final int price;
  final int operationCost;
  String image;
  List<String> images;
  int brokerId;
  int saleId;

  Home(
    this.id,
    this.address,
    this.description,
    this.livingSpace,
    this.rooms,
    this.built,
    this.price,
    this.operationCost,
    this.image,
    this.images,
    this.brokerId,
    this.saleId,
  );

  static String formatCurrency(int price, String unit) {
    double priceD = price.toDouble();
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: priceD,
      settings: MoneyFormatterSettings(
        symbol: unit,
        thousandSeparator: ' ',
        fractionDigits: 0,
      ),
    );
    return fmf.output.symbolOnRight;
  }
}

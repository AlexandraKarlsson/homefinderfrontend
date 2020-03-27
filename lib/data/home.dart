import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Home {
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
  );

  static String formatCurrency(int price, String unit) {
    double priceD = price.toDouble();
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: priceD,
        settings: MoneyFormatterSettings(
          symbol: unit,
          thousandSeparator: ' ',
          //decimalSeparator: ',',
          //symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          //compactFormatType: CompactFormatType.sort
        ));
    return fmf.output.symbolOnRight;
  }
}

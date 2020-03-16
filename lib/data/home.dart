import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Home {
  
  static String formatPrice(int price) {
    double priceD = price.toDouble();
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
    amount: priceD,
    settings: MoneyFormatterSettings(
        symbol: 'kr',
        thousandSeparator: ' ',
        //decimalSeparator: ',',
        //symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
        //compactFormatType: CompactFormatType.sort
      )
    );
    return fmf.output.symbolOnRight;
  }
}
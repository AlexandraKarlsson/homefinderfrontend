import 'package:flutter/material.dart';

import 'user_bid.dart';

class UserBids extends ChangeNotifier {
  List<UserBid> bidList = [];

  void add(Map<String, dynamic> userBidsMap) {
    clear();
    userBidsMap['rows'].forEach((userBid) {
      int saleId = userBid['saleid'];
      int price = userBid['price'];
      UserBid bid = UserBid(saleId,price);
      bidList.add(bid);
    });
  }
  
  void checkHighestPrice(int saleId, int highestPrice) {
    bidList.forEach((userBid) {
      if(userBid.saleId == saleId) {
        if(userBid.price < highestPrice) {
          userBid.isHighest = false;
        } else {
          userBid.isHighest = true;
        }
      }
    });
    notifyListeners();
  }

 
 void clear() {
    bidList.clear();
  }
}

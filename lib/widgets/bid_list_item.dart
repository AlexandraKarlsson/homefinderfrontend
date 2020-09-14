import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../pages/home_detail.dart';
import '../pages/make_bid.dart';
import '../data/home.dart';
import '../data/user_bid.dart';

class BidListItem extends StatelessWidget {
  final Home home;
  final UserBid userBid;

  BidListItem(this.userBid,this.home) : super(key: Key(userBid.saleId.toString()));

  @override
  Widget build(BuildContext context) {

    // TODO: Indicate if price is overbidden then mark red

    return Container(
      child: Card(
        color: userBid.isHighest ? Colors.green[200] : Colors.red[200],
        elevation: 5,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeDetail(home)));
          },
          child: ListTile(
            leading: Image.network(
              'http://10.0.2.2:8010/images/${home.image}',
            ),
            title: Text(
              home.address,
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
                'Area: ${home.livingSpace}, Antal rum: ${home.rooms}',
                style: TextStyle(fontSize: 12)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  Home.formatCurrency(home.price, 'kr'),
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[                              
                      InkWell(
                        child: Icon(Icons.gavel),
                        onTap: () {
                          print('Bid clicked');
                          Navigator.pushNamed(
                            context,
                            MakeBid.PATH,
                            arguments: home,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


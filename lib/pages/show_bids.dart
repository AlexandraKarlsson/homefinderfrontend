import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../widgets/bid_list_item.dart';

import '../data/user.dart';
import '../data/user_bids.dart';
import '../data/home.dart';
import '../data/apartments.dart';
import '../data/houses.dart';

class ShowBids extends StatefulWidget {
  static const String PATH = 'showBids';

  @override
  _ShowBidsState createState() => _ShowBidsState();
}

class _ShowBidsState extends State<ShowBids> {
  UserBids userBids = UserBids();

  @override
  didChangeDependencies() {
    print('Running didChangeDependencies ...');
    super.didChangeDependencies();
    final userBidsTemp = Provider.of<UserBids>(context);
    if (userBidsTemp != this.userBids) {
      print('Running fetchBids()...');
      this.userBids = userBidsTemp;
      _fetchBids(context);
    }
  }

  Future<void> _fetchHigestBids(User user,/* UserBids userBids*/) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': user.token
    };

    userBids.bidList.forEach((bid) async {
      final url = 'http://10.0.2.2:8000/bid/highest/${bid.saleId}';
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        print('Fetch highest bid successful');
        final data = convert.json.decode(response.body) as dynamic;
        print(data["result"]);
        final highestPrice = data["result"];
        userBids.checkHighestPrice(bid.saleId, highestPrice);
      } else {
        print(
            'OOOPS, Something nasty happend in the backend or in the protcol!');
      }
    });
  }

  Future<void> _fetchBids(BuildContext context) async {
    User user = Provider.of<User>(context);

    const url = 'http://10.0.2.2:8000/bid/user';
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': user.token
    };
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
     // UserBids userBids = Provider.of<UserBids>(context);
      final data = convert.json.decode(response.body) as Map<String, dynamic>;
      print('data.length = ${data.length}');
      userBids.add(data);
      print('userBids.bidList.length = ${userBids.bidList.length}');
      await _fetchHigestBids(user, /*userBids*/);
    } else {
      print('OOOPS, Something nasty happend in the backend or in the protcol!');
    }
  }

  Home _getHome(int saleId, Apartments apartments, Houses houses) {
    List homes = [...apartments.apartments, ...houses.houses];
    for (Home home in homes) {
      if (home.saleId == saleId) {
        return home;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Apartments apartments = Provider.of<Apartments>(context);
    Houses houses = Provider.of<Houses>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Visa bud sidan')),
      body: Column(
        children: <Widget>[
          Container(
            child: Text('Här har du dina bud'),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: userBids.bidList.length,
                itemBuilder: (BuildContext context, int index) {
                  return BidListItem(
                      userBids.bidList[index],
                      _getHome(
                        userBids.bidList[index].saleId,
                        apartments,
                        houses,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../pages/home_detail.dart';
import '../pages/make_bid.dart';
import '../data/home.dart';
import '../data/user.dart';
import '../data/favorites.dart';

class HomeListItem extends StatelessWidget {
  final Home home;

  const HomeListItem({@required this.home});

  Future<void> updateFavorites(Favorites favorites, String token) async {
    bool addFavorite = !favorites.exists(home.id);
    if (addFavorite) {
      const url = 'http://10.0.2.2:8000/favorite';
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth': token
      };
      final newFavoriteData = {
        'homeid': home.id,
      };
      final newFavoriteDataJson = convert.jsonEncode(newFavoriteData);
      final response = await http.post(
        url,
        headers: headers,
        body: newFavoriteDataJson,
      );
      if (response.statusCode == 201) {
        favorites.put(home.id);
      } else {
        print(
            'Add favorites request failed with status: ${response.statusCode}.');
      }
    } else {
      // removeFavorite
      final url = 'http://10.0.2.2:8000/favorite/${home.id}';
      print('url = $url');
      final headers = <String, String>{'x-auth': token};
      final response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        favorites.remove(home.id);
      } else {
        print(
            'Remove favorites request failed with status: ${response.statusCode}.');
      }
    }
  }
/* 
  Future<void> createBid(
      BuildContext context, int biddingPrice, String token) async {
    const url = 'http://10.0.2.2:8000/bid';
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': token
    };
    final newBidData = {
      'saleid': home.saleId,
      'price': biddingPrice,
    };
    final newBidDataJson = convert.jsonEncode(newBidData);
    final response = await http.post(
      url,
      headers: headers,
      body: newBidDataJson,
    );
    if (response.statusCode == 201) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Budet gick igenom'),
                  SizedBox(width: 5),
                  Icon(Icons.gavel),
                ]),
            content: Container(),
            actions: <Widget>[
              FlatButton(
                child: Text('OK',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print(
          'Add favorites request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _showBidDialog(BuildContext context, User user) async {
    TextEditingController priceController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Bud'),
                SizedBox(width: 5),
                Icon(Icons.gavel),
              ]),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.network(
                  'http://10.0.2.2:8010/images/${home.image}',
                ),
                SizedBox(height: 30),
                Text(
                  'Aktuellt bud',
                  style: TextStyle(fontSize: 13),
                ),
                Text('${home.price} kr'),
                SizedBox(height: 20),
                /*Text(
                  'Ditt bud',
                  style: TextStyle(fontSize: 13),
                ),*/
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Ditt budpris',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('BUDA',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              onPressed: () {
                int biddingPrice = int.parse(priceController.text);
                print('Ditt budpris: ${biddingPrice.toString()}');

                createBid(context, biddingPrice, user.token);

                // TODO: Call backend to create bid
                // TODO: Show alert with spinner if possible
                // TODO: Show result from backend
                // TODO: If bid was unsuccessful update price and show dialog
                // TODO: If bid was successful just pop

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    Favorites favorites = Provider.of<Favorites>(context);
    User user = Provider.of<User>(context);

    return Container(
      child: Card(
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
                        child: Icon(favorites.exists(home.id)
                            ? Icons.star
                            : Icons.star_border),
                        onTap: () {
                          if (user.token != null) {
                            updateFavorites(favorites, user.token);
                          }
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
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

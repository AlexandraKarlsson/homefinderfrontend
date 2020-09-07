import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/home.dart';
import '../data/user.dart';
import '../data/apartment.dart';
import '../data/apartments.dart';
import '../data/house.dart';
import '../data/houses.dart';
import '../data/bid.dart';
import '../widgets/show_dialog_message.dart';

class MakeBid extends StatefulWidget {
  static const String PATH = 'makeBid';

  @override
  _MakeBidState createState() => _MakeBidState();
}

class _MakeBidState extends State<MakeBid> {
  Home home;
  User user;
  TextEditingController priceController = TextEditingController();
  bool _showBidHistory = false;
  List<Bid> bids = [];
  bool _isBusy = false;

  Future<void> createBid(
    BuildContext context,
    int biddingPrice,
    String token,
  ) async {
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
      if (home is Apartment) {
        print('Home is an Apartment');
        Apartments apartments = Provider.of<Apartments>(context);
        apartments.changePrice(home.id, biddingPrice);
      } else if (home is House) {
        print('Home is an House');
        Houses houses = Provider.of<Houses>(context);
        houses.changePrice(home.id, biddingPrice);
      } else {
        print('Home is unknown');
      }
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.gavel),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Budet gick igenom'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.gavel),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Budet gick inte igenom, försök igen!'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> updatePrice(String token, Home home) async {
    final url = 'http://10.0.2.2:8000/bid/highest/${home.saleId}';
    print('url=$url');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': token
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print('updatePrice successful');
      final data = convert.json.decode(response.body) as dynamic;
      print(data);
      print(data["result"]);
      final highestPrice = data["result"];

      if (home is Apartment) {
        print('Home is an Apartment');
        Apartments apartments = Provider.of<Apartments>(context);
        apartments.changePrice(home.id, highestPrice);
      } else if (home is House) {
        print('Home is an House');
        Houses houses = Provider.of<Houses>(context);
        houses.changePrice(home.id, highestPrice);
      } else {
        print('Home is unknown');
      }
    } else {
      print('updatePrice failed');
      print(response);
    }
  }

  Future<void> fetchAllBids(String token, Home home) async {
    setState(() {
      _isBusy = true;
    });

    final url = 'http://10.0.2.2:8000/bid/all/${home.saleId}';
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': token
    };
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('fetchAllBids successful');
      final data = convert.json.decode(response.body) as List<dynamic>;
      print(data[0]["price"]);
      List<Bid> newBids = List();

      data.forEach((bid) {
        String date = bid["date"];
        int price = bid["price"];
        int userId = bid["userid"];
        Bid newBid = Bid(date, userId, price);
        newBids.add(newBid);
      });
      setState(() {
        bids = newBids;
      });
    } else {
      print('fetchAllBids failed');
      print(response);
    }
    setState(() {
      _isBusy = false;
    });
  }

  Widget buildBidTable() {
    List<DataRow> dataRows = List();
    bids.forEach((bid) {
      DataRow dataRow = DataRow(cells: [
        DataCell(Text(bid.date)),
        DataCell(Text(bid.userId.toString())),
        DataCell(Text(Home.formatCurrency(bid.price, 'kr'))),
      ]);
      dataRows.add(dataRow);
    });

    return DataTable(columns: [
      DataColumn(label: Text('Datum')),
      DataColumn(label: Text('Användare')),
      DataColumn(label: Text('Pris')),
    ], rows: dataRows);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    home = ModalRoute.of(context).settings.arguments;

    return _isBusy
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: Text('Buda')),
            body: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            '${home.address}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Image.network(
                            'http://10.0.2.2:8010/images/${home.image}',
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Aktuellt bud',
                            style: TextStyle(fontSize: 13),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                Home.formatCurrency(home.price, 'kr'),
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: _showBidHistory
                                    ? Icon(Icons.keyboard_arrow_up)
                                    : Icon(Icons.keyboard_arrow_down),
                                onPressed: () {
                                  if (_showBidHistory) {
                                    setState(() {
                                      _showBidHistory = false;
                                    });
                                  } else {
                                    fetchAllBids(user.token, home);
                                    setState(() {
                                      _showBidHistory = true;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                          _showBidHistory ? buildBidTable() : Container(),
                          TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              labelText: 'Ditt budpris',
                            ),
                          ),
                          SizedBox(height: 15),
                          RaisedButton(
                            child: Text(
                              'BUDA',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              int biddingPrice;
                              try {
                                biddingPrice = int.parse(priceController.text);
                              } catch (error) {
                                biddingPrice = 0;
                              }
                              print('Ditt budpris: ${biddingPrice.toString()}');
                              if (home.price < biddingPrice) {
                                createBidAndUpdatePrice(context, biddingPrice);
                              } else {
                                showDialogMessage(
                                  context,
                                  "Inputfel",
                                  "Ditt budpris är lägre än aktuellt budpris, höj budet!",
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> createBidAndUpdatePrice(BuildContext context, int biddingPrice) async {
    print('Creating bid');
    setState(() {
      _isBusy = true;
    });
    await createBid(context, biddingPrice, user.token);
    print('Update highest price');
    await updatePrice(user.token, home);
    setState(() {
      _isBusy = false;
    });
  }
}

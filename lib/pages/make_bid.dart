import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/home.dart';
import '../data/user.dart';

class MakeBid extends StatefulWidget {
  static const String PATH = 'makeBid';

  @override
  _MakeBidState createState() => _MakeBidState();
}

class _MakeBidState extends State<MakeBid> {
  Home home;
  User user;
  TextEditingController priceController = TextEditingController();

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

  Future<void> updatePrice(String token,Home home) async {
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
      home.price = highestPrice;
    } else {
      print('updatePrice failed');
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    home = ModalRoute.of(context).settings.arguments;
    user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Buda')),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
              Text(
                Home.formatCurrency(home.price, 'kr'),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              RaisedButton(
                child: Text(
                  'BUDA',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  int biddingPrice = int.parse(priceController.text);
                  print('Ditt budpris: ${biddingPrice.toString()}');
                  

                  // TODO: Check if the bidding price is lower then the original price
                  createBid(context, biddingPrice, user.token);
                  print('Update highest price');
                  updatePrice(user.token,home);
                  
                  // TODO: Show alert with spinner if possible
                  // TODO: If bid was unsuccessful update price and show dialog
              
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


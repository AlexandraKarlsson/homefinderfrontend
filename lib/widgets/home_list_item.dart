import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../pages/home_detail.dart';
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

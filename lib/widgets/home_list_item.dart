import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/home_detail.dart';
import '../data/home.dart';
import '../data/favorites.dart';

class HomeListItem extends StatelessWidget {
  final Home home;

  const HomeListItem({@required this.home});

  @override
  Widget build(BuildContext context) {
    Favorites favorites = Provider.of<Favorites>(context);

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
                      Icon(favorites.exists(home.id) ? Icons.star : Icons.star_border),
                      SizedBox(width: 4,),
                      InkWell(
                        child: Icon(Icons.shopping_cart),
                        onTap: () {
                          print('Cart clicked');
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

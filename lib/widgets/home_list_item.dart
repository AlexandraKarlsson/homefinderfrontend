import 'package:flutter/material.dart';
import '../pages/home_detail.dart';
import '../data/home.dart';

class HomeListItem extends StatelessWidget {

  final Home home;

  const HomeListItem({ @required this.home });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, HomeDetail.HOME_PATH);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomeDetail(home)));
          },
          child: ListTile(
            leading: Image.asset(
              'assets/images/${home.image}',
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
              children: <Widget>[
                Text(
                  Home.formatCurrency(home.price, 'kr'),
                  style: TextStyle(fontSize: 14),
                ),
                Icon(Icons.shopping_cart)
              ],
            ),
          ),
        ),
      ),
    );
  }
}